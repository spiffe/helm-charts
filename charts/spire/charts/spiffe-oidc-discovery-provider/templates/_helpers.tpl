{{/*
Expand the name of the chart.
*/}}
{{- define "spiffe-oidc-discovery-provider.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "spiffe-oidc-discovery-provider.fullname" -}}
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
{{- define "spiffe-oidc-discovery-provider.namespace" -}}
  {{- if .Values.namespaceOverride -}}
    {{- .Values.namespaceOverride -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "spiffe-oidc-discovery-provider.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "spiffe-oidc-discovery-provider.labels" -}}
helm.sh/chart: {{ include "spiffe-oidc-discovery-provider.chart" . }}
{{ include "spiffe-oidc-discovery-provider.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "spiffe-oidc-discovery-provider.selectorLabels" -}}
app.kubernetes.io/name: {{ include "spiffe-oidc-discovery-provider.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "spiffe-oidc-discovery-provider.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "spiffe-oidc-discovery-provider.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "spiffe-oidc-discovery-provider.image" -}}
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

{{- define "spiffe-oidc-discovery-provider.workload-api-socket-path" -}}
{{- printf "/spiffe-workload-api/%s" .Values.agentSocketName }}
{{- end }}

{{- define "spiffe-oidc-discovery-provider.cluster-name" }}
{{- if ne (len (dig "spire" "clusterName" "" .Values.global)) 0 }}
{{- .Values.global.spire.clusterName }}
{{- else }}
{{- .Values.clusterName }}
{{- end }}
{{- end }}

{{- define "spiffe-oidc-discovery-provider.trust-domain" }}
{{- if ne (len (dig "spire" "trustDomain" "" .Values.global)) 0 }}
{{- .Values.global.spire.trustDomain }}
{{- else }}
{{- .Values.trustDomain }}
{{- end }}
{{- end }}

{{- define "spiffe-oidc-discovery-provider.cluster-domain" }}
{{- if ne (len (dig "k8s" "clusterDomain" "" .Values.global)) 0 }}
{{- .Values.global.k8s.clusterDomain }}
{{- else }}
{{- .Values.clusterDomain }}
{{- end }}
{{- end }}
