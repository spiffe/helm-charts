{{/*
Expand the name of the chart.
*/}}
{{- define "spire.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "spire.fullname" -}}
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
Create chart name and version as used by the chart label.
*/}}
{{- define "spire.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "spire.labels" -}}
helm.sh/chart: {{ include "spire.chart" . }}
{{ include "spire.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "spire.selectorLabels" -}}
app.kubernetes.io/name: {{ include "spire.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common server labels
*/}}
{{- define "spire.server.labels" -}}
helm.sh/chart: {{ include "spire.chart" . }}
{{ include "spire.server.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector server labels
*/}}
{{- define "spire.server.selectorLabels" -}}
app.kubernetes.io/name: {{ include "spire.name" . }}-server
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common agent labels
*/}}
{{- define "spire.agent.labels" -}}
helm.sh/chart: {{ include "spire.chart" . }}
{{ include "spire.agent.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector agent labels
*/}}
{{- define "spire.agent.selectorLabels" -}}
app.kubernetes.io/name: {{ include "spire.name" . }}-agent
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common oidc labels
*/}}
{{- define "spire.oidc.labels" -}}
helm.sh/chart: {{ include "spire.chart" . }}
{{ include "spire.oidc.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector oidc labels
*/}}
{{- define "spire.oidc.selectorLabels" -}}
app.kubernetes.io/name: {{ include "spire.name" . }}-oidc
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "spire.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "spire.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "spire.image" -}}
{{- if eq (substr 0 7 .image.version) "sha256:" -}}
{{- printf "%s/%s@%s" .image.registry .image.repository .image.version -}}
{{- else if .appVersion -}}
{{- printf "%s/%s:%s" .image.registry .image.repository (default .appVersion .image.version) -}}
{{- else if .image.version -}}
{{- printf "%s/%s:%s" .image.registry .image.repository .image.version -}}
{{- else -}}
{{- printf "%s/%s" .image.registry .image.repository -}}
{{- end -}}
{{- end }}

{{- define "spire.server-upstream-ca-secret" -}}
{{- $root := . }}
{{- with .Values.server.config.upstreamAuthority.disk -}}
{{- if eq (.secret.create | toString) "true" -}}
{{ include "spire.fullname" $root }}-upstream-ca
{{- else -}}
{{ default (include "spire.fullname" $root) .secret.name }}
{{- end -}}
{{- end -}}
{{- end }}
