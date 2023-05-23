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
{{- $repo := .image.repository }}
{{- $tag := (default .image.tag .image.version) | toString }}
{{- if eq (substr 0 7 $tag) "sha256:" }}
{{- printf "%s/%s@%s" $registry $repo $tag }}
{{- else if .appVersion }}
{{- printf "%s/%s:%s" $registry $repo (default .appVersion $tag) }}
{{- else if $tag }}
{{- printf "%s/%s:%s" $registry $repo $tag }}
{{- else }}
{{- printf "%s/%s" $registry $repo }}
{{- end }}
{{- end }}

{{/* Takes in a dictionary with keys:
 * ingress - the standardized ingress object
 * svcName - The service to route to
 * port - which port on the service to use
*/}}
{{ define "spire-lib.ingress-spec" }}
{{- $svcName := .svcName }}
{{- $port := .port }}
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
