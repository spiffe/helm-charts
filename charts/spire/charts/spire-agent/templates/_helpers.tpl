{{/*
Expand the name of the chart.
*/}}
{{- define "spire-agent.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "spire-agent.fullname" -}}
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
{{- define "spire-agent.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "spire-agent.labels" -}}
helm.sh/chart: {{ include "spire-agent.chart" . }}
{{ include "spire-agent.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "spire-agent.selectorLabels" -}}
app.kubernetes.io/name: {{ include "spire-agent.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "spire-agent.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "spire-agent.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "spire-agent.image" -}}
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

{{- define "spire-agent.agent-socket-path" -}}
{{ include .Values.socketMacroName . }}
{{- end }}

{{- define "spire-agent.agent-socket-path-standalone" -}}
{{- print .Values.agentSocketPath }}
{{- end }}
