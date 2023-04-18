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
{{- if ne (len .Values.nodeAttestor.k8sPsat.serviceAccountAllowList) 0 }}
{{- .Values.nodeAttestor.k8sPsat.serviceAccountAllowList | toJson }}
{{- else }}
[{{ printf "%s:%s-agent" .Release.Namespace .Release.Name | quote }}]
{{- end }}
{{- end }}

{{ define "spire-server.profile-values" }}
{{- $files := .Files }}
{{- $tmp := dict "Values" (deepCopy .Values) }}
{{- $l := concat .Values.global.spire.profiles .Values.profiles }}
{{- range $l }}
  {{- $n := $files.Get ( printf "profiles/%s.yaml" . ) | fromYaml }}
  {{- $nv := mustMergeOverwrite $n $tmp.Values }}
  {{- $_ := set $tmp "Values" $nv }}
{{- end }}
{{/* Any value that is still default after the user can override should be overridden by our profile setting. */}}
{{- if has "production" $l }}
  {{- if eq .Values.notifier.k8sbundle.namespace ""}}
    {{- $_ := set $tmp.Values.notifier.k8sbundle "namespace" "spire-system" }}
  {{- end }}
  {{- if eq (len .Values.nodeAttestor.k8sPsat.serviceAccountAllowList ) 0}}
    {{- $_ := set $tmp.Values.nodeAttestor.k8sPsat "serviceAccountAllowList" (list "spire-system:spire-agent") }}
  {{- end }}
  {{- $_ := set $tmp.Values.dataStorage "enabled" true }}
{{- end }}
{{- if has "expose-spire-server-ingress-nginx" $l }}
  {{- $_ := set $tmp.Values.ingress "enabled" true }}
{{- end }}
{{- if has "expose-federation-https-web-ingress-nginx" $l }}
  {{- $_ := set $tmp.Values.federation.ingress "enabled" true }}
{{- end }}
{{- if has "expose-federation-https-spiffe-ingress-nginx" $l }}
  {{- $_ := set $tmp.Values.federation.ingress "enabled" true }}
{{- end }}
{{- $tmp.Values | toYaml }}
{{- end }}
