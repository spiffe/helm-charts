{{/*
Expand the name of the chart.
*/}}
{{- define "tornjak-frontend.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "tornjak-frontend.fullname" -}}
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
{{- define "tornjak-frontend.namespace" -}}
  {{- if .Values.namespaceOverride -}}
    {{- .Values.namespaceOverride -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "tornjak-frontend.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "tornjak-frontend.cluster-domain" -}}
{{- if ne (len (dig "k8s" "clusterDomain" "" .Values.global)) 0 }}
{{- .Values.global.k8s.clusterDomain }}
{{- else }}
{{- .Values.clusterDomain }}
{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "tornjak-frontend.labels" -}}
helm.sh/chart: {{ include "tornjak-frontend.chart" . }}
{{ include "tornjak-frontend.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "tornjak-frontend.selectorLabels" -}}
app.kubernetes.io/name: {{ include "tornjak-frontend.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "tornjak-frontend.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "tornjak-frontend.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create an image name
*/}}
{{- define "tornjak-frontend.image" -}}
{{- if eq (substr 0 7 .image.version) "sha256:" -}}
{{- printf "%s/%s@%s" .image.registry
    .image.repository .image.version -}}
{{- else if .appVersion -}}
{{- printf "%s/%s:%s"
   .image.registry
    .image.repository
    (default .appVersion
             .image.version) -}}
{{- else if
    .Values.tornjakFrontend.image.version -}}
{{- printf "%s/%s:%s"
    .Values.tornjakFrontend.image.registry
    .Values.tornjakFrontend.image.repository
    .Values.tornjakFrontend.image.version -}}
{{- else -}}
{{- printf "%s/%s"
    .Values.tornjakFrontend.image.registry
    .Values.tornjakFrontend.image.repository -}}
{{- end -}}
{{- end }}

{{/*
Create URL for accessing Tornjak APIs
*/}}
{{- define "tornjak-frontend.apiURL" -}}
{{- if .Values.apiServerURL -}}
{{-  .Values.apiServerURL -}}
{{- else }}
{{- $feurl := print "http://localhost:" .Values.service.port }}
{{- $feurl }}
{{- end }}
{{- end }}

{{/*
Create URL for accessing Tornjak UI
*/}}
{{- define "tornjak-frontend.frontendURL" -}}
{{- $feurl := print "http://localhost:" .Values.service.port }}
{{- $feurl }}
{{- end }}


