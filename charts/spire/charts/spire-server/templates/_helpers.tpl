{{/*
Expand the name of the chart.
*/}}
{{- define "spire-server.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "spire-server.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts
*/}}
{{- define "spire-server.namespace" -}}
  {{- if .Values.namespaceOverride -}}
    {{- .Values.namespaceOverride -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}

{{- define "spire-server.podMonitor.namespace" -}}
  {{- if ne (len .Values.telemetry.prometheus.podMonitor.namespace) 0 }}
    {{- .Values.telemetry.prometheus.podMonitor.namespace }}
  {{- else if ne (len (dig "telemetry" "prometheus" "podMonitor" "namespace" "" .Values.global)) 0 }}
    {{- .Values.global.telemetry.prometheus.podMonitor.namespace }}
  {{- else }}
    {{- include "spire-server.namespace" . }}
  {{- end }}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "spire-server.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "spire-server.labels" -}}
helm.sh/chart: {{ include "spire-server.chart" . }}
{{ include "spire-server.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "spire-server.selectorLabels" -}}
app.kubernetes.io/name: {{ include "spire-server.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "spire-server.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "spire-server.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "spire-server.upstream-ca-secret" -}}
{{- $root := . }}
{{- with .Values.upstreamAuthority.disk -}}
{{- if eq (.secret.create | toString) "true" -}}
{{ include "spire-server.fullname" $root }}-upstream-ca
{{- else -}}
{{ default (include "spire-server.fullname" $root) .secret.name }}
{{- end -}}
{{- end -}}
{{- end }}

{{- define "spire-controller-manager.fullname" -}}
{{ include "spire-server.fullname" . | trimSuffix "-server" }}-controller-manager
{{- end }}

{{- define "spire-server.serviceAccountAllowedList" }}
{{- if ne (len .Values.nodeAttestor.k8s_psat.serviceAccountAllowList) 0 }}
{{- .Values.nodeAttestor.k8s_psat.serviceAccountAllowList | toJson }}
{{- else }}
[{{ printf "%s:%s-agent" .Release.Namespace .Release.Name | quote }}]
{{- end }}
{{- end }}


{{/*
Take a copy of a plugin values, and output mergable config
*/}}
{{- define "spire-server.config_mergeable" }}
{{- $config := . }}
{{- $newConfig := dict }}
{{- range (list "plugin_cmd" "plugin_checksum" "plugin_data") }}
{{- if hasKey $config . }}
{{- $_ := set $newConfig . (index $config .) }}
{{- end }}
{{- end }}
{{- toYaml $newConfig }}
{{- end }}

{{/*
Take a copy of the config and merge in plugins passed through as root.
*/}}
{{- define "spire-server.config_merge" }}
{{- $newConfig := .config | fromYaml }}
{{- $root := .root }}
{{- $sections := list (list "nodeAttestor" "NodeAttestor") (list "notifier" "Notifier") (list "keyManager" "KeyManager") (list "upstreamAuthority" "UpstreamAuthority") }}
{{- range $section := $sections }}
{{- $vsection := index $section 0 }}
{{- $csection := index $section 1 }}
{{- if not (hasKey $newConfig.plugins $csection) }}
{{- $_ := set $newConfig.plugins $csection (dict) }}
{{- end }}
{{- $cdict := index $newConfig.plugins $csection }}
{{- $vdict := index $root.Values $vsection }}
{{- range $name, $v := $vdict }}
{{- $oldV := index $cdict $name | default (dict) }}
{{- $newV := $oldV | mustMerge (include "spire-server.config_mergeable" $v | fromYaml) }}
{{- if or (not (hasKey $v "enabled")) (eq ($v.enabled | toString) "true") }}
{{- $_ := set $cdict $name $newV }}
{{- end }}
{{- end }}
{{- if eq (len $cdict) 0 }}
{{- $_ := unset $newConfig.plugins $csection }}
{{- end }}
{{- end }}
{{- $newConfig | toYaml }}
{{- end }}

{{/*
Take a copy of the plugin section and return a yaml string based version
reformatted from a dict of dicts to a dict of lists of dicts
*/}}
{{- define "spire-server.plugins_reformat" }}
{{- range $type, $v := . }}
{{ $type }}:
  {{- $names := sortAlpha (keys $v) }}
  {{- range $name := $names }}
    {{- $v2 := index $v $name }}
    - {{ $name }}: {{ $v2 | toYaml | nindent 8 }}
  {{- end }}
{{- end }}
{{- end }}

{{/*
Take a copy of the config as a yaml config and root var.
Merge in .root.Values.plugin into config,
Reformat the plugin section from a dict of dicts to a dict of lists of dicts,
and export it back as as json string.
This makes it much easier for users to merge in plugin configs, as dicts are easier
to merge in values, but spire needs arrays.
*/}}
{{- define "spire-server.reformat-and-yaml2json" -}}
{{- $config := include "spire-server.config_merge" . | fromYaml }}
{{- $plugins := include "spire-server.plugins_reformat" $config.plugins | fromYaml }}
{{- $_ := set $config "plugins" $plugins }}
{{- $config | toPrettyJson }}
{{- end }}
