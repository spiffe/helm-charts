{{- define "spire-lib.cluster-name" }}
{{- if ne (len (dig "spire" "clusterName" "" .Values.global)) 0 }}
{{- .Values.global.spire.clusterName }}
{{- else }}
{{- .Values.clusterName }}
{{- end }}
{{- end }}

{{- define "spire-lib.trust-domain" }}
{{- if ne (len (dig "spire" "trustDomain" "" .Values.global)) 0 }}
{{- .Values.global.spire.trustDomain }}
{{- else }}
{{- .Values.trustDomain }}
{{- end }}
{{- end }}

{{- define "spire-lib.bundle-configmap" }}
{{- if ne (len (dig "spire" "bundleConfigMap" "" .Values.global)) 0 }}
{{- .Values.global.spire.bundleConfigMap }}
{{- else }}
{{- .Values.bundleConfigMap }}
{{- end }}
{{- end }}

{{- define "spire-lib.cluster-domain" -}}
{{- if ne (len (dig "k8s" "clusterDomain" "" .Values.global)) 0 }}
{{- .Values.global.k8s.clusterDomain }}
{{- else }}
{{- .Values.clusterDomain }}
{{- end }}
{{- end }}

{{- define "spire-lib.registry" }}
{{- if ne (len (dig "spire" "image" "registry" "" .global)) 0 }}
{{- .global.spire.image.registry }}
{{- else }}
{{- .image.registry }}
{{- end }}
{{- end }}

{{- define "spire-lib.image" -}}
{{- $registry := include "spire-lib.registry" . }}
{{- if eq (substr 0 7 .image.version) "sha256:" -}}
{{- printf "%s/%s@%s" $registry .image.repository .image.version -}}
{{- else if .appVersion -}}
{{- printf "%s/%s:%s" $registry .image.repository (default .appVersion .image.version) -}}
{{- else if .image.version -}}
{{- printf "%s/%s:%s" $registry .image.repository .image.version -}}
{{- else -}}
{{- printf "%s/%s" $registry .image.repository -}}
{{- end -}}
{{- end }}

{{/* Takes in a dictionary with keys:
 * ingress - the standardized ingress object
 * name - The standardized object name
 * svcName - The service to route to
 * port - which port on the service to use
 * labels - lables to add to the ingress
*/}}
{{ define "spire-lib.ingress-template" }}
{{- $svcName := .svcName }}
{{- $port := .port }}
{{- if .ingress.enabled -}}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ .name }}
  labels:
    {{ .labels | nindent 4 }}
  {{- with .ingress.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  {{- with .ingress.className }}
  ingressClassName: {{ . | quote }}
  {{- end }}
  {{- if .ingress.tls }}
  tls:
    {{- range .ingress.tls }}
    - hosts:
        {{- range .hosts }}
        - {{ . | quote }}
        {{- end }}
      secretName: {{ .secretName | quote }}
    {{- end }}
  {{- end }}
  rules:
    {{- range .ingress.hosts }}
    - host: {{ .host | quote }}
      http:
        paths:
          {{- range .paths }}
          - path: {{ .path }}
            pathType: {{ .pathType }}
            backend:
              service:
                name: {{ $svcName | quote }}
                port:
                  number: {{ $port }}
          {{- end }}
    {{- end }}
{{- end }}
{{- end }}
