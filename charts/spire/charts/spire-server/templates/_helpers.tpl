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

{{- define "spire-server.config-mysql-query" }}
{{- $lst := list }}
{{- range . }}
{{- range $key, $value := . }}
{{- $eValue := toString $value }}
{{- $entry := printf "%s=%s" (urlquery $key) (urlquery $eValue) }}
{{- $lst = append $lst $entry }}
{{- end }}
{{- end }}
{{- if gt (len $lst) 0 }}
{{- printf "?%s" (join "&" $lst) }}
{{- end }}
{{- end }}

{{- define "spire-server.config-postgresql-options" }}
{{- $lst := list }}
{{- range . }}
{{- range $key, $value := . }}
{{- $eValue := toString $value }}
{{- $entry := printf "%s=%s" $key $eValue }}
{{- $lst = append $lst $entry }}
{{- end }}
{{- end }}
{{- if gt (len $lst) 0 }}
{{- printf " %s" (join " " $lst) }}
{{- end }}
{{- end }}

{{- define "spire-server.datastore-config" }}
{{- $config := deepCopy .Values.dataStore.sql.plugin_data }}
{{- if .Values.postgresql.enabled }}
  {{- $_ := set $config "database_type" "postgres" }}
  {{- $pgValues := dict "Values" .Values.postgresql "global" .Values.global "Template" (dict "Name" "" "BasePath" "") }}
  {{- $database := include "postgresql.database" $pgValues }}
  {{- $user := include "postgresql.username" $pgValues }}
  {{- $password := $pgValues.Values.auth.password }}
  {{- $host := "spire-postgresql" }}
  {{- $port := int (include "postgresql.service.port" $pgValues) }}
  {{- $_ := set $config "connection_string" (printf "dbname=%s user=%s password=%s host=%s port=%d sslmode=disable" $database $user $password $host $port )}}
{{- else if .Values.mysql.enabled }}
  {{- $_ := set $config "database_type" "mysql" }}
  {{- $database := .Values.mysql.auth.database }}
  {{- $user := .Values.mysql.auth.username }}
  {{- $password := .Values.mysql.auth.password }}
  {{- $host := "spire-mysql" }}
  {{- $port := int .Values.mysql.primary.service.ports.mysql }}
  {{- $_ := set $config "connection_string" (printf "%s:%s@tcp(%s:%d)/%s?parseTime=true" $user $password $host $port $database )}}
{{- else if eq .Values.dataStore.sql.database_type "sqlite3" }}
  {{- $_ := set $config "database_type" "sqlite3" }}
  {{- $_ := set $config "connection_string" "/run/spire/data/datastore.sqlite3" }}
{{- else if eq .Values.dataStore.sql.database_type "mysql" }}
  {{- $_ := set $config "database_type" "mysql" }}
  {{- $query := include "spire-server.config-mysql-query" .Values.dataStore.sql.options }}
  {{- $_ := set $config "connection_string" (printf "%s:%s@tcp(%s:%d)/%s%s" .Values.dataStore.sql.username .Values.dataStore.sql.password .Values.dataStore.sql.host (int .Values.dataStore.sql.port) .Values.dataStore.sql.database $query) }}
{{- else if eq .Values.dataStore.sql.database_type "postgresql" }}
  {{- $_ := set $config "database_type" "postgresql" }}
  {{- $options:= include "spire-server.config-postgresql-options" .Values.dataStore.sql.options }}
  {{- $_ := set $config "connection_string" (printf "dbname=%s user=%s password=%s host=%s port=%d%s" .Values.dataStore.sql.database .Values.dataStore.sql.username .Values.dataStore.sql.password .Values.dataStore.sql.host (int .Values.dataStore.sql.port) $options) }}
{{- else }}
  {{- fail "Unsupported database type" }}
{{- end }}
{{- $config | toYaml }}
{{- end }}
