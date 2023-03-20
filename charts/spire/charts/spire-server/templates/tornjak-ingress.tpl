{{- if eq (.Values.tornjak.enabled | toString) "true" }}

{{- if .Values.tornjak }}
{{- if .Values.tornjak.config }}

{{- if .Values.tornjak.config.frontend }}
{{- if .Values.tornjak.config.frontend.ingress }}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ include "spire-tornjak.frontend" . }}
  namespace: {{ include "spire-server.namespace" . }} 
spec:
  rules:
  - host: {{ .Values.tornjak.config.frontend.ingress }}
    http:
      paths:
      - pathType: Prefix
        path: "/"
        backend:
          service:
            name: {{ include "spire-tornjak.frontend" . }}
            port: 
              number: 3000
{{- end }}
{{- end }}

{{- if .Values.tornjak.config.backend }}
{{- if .Values.tornjak.config.backend.ingress }}
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ include "spire-tornjak.backend" . }}
  namespace: {{ include "spire-server.namespace" . }} 
spec:
  rules:
  - host: {{ .Values.tornjak.config.backend.ingress }}
    http:
      paths:
      - pathType: Prefix
        path: "/"
        backend:
          service:
            name: {{ include "spire-tornjak.backend" . }}
            port: 
              number: 10000
{{- end }}
{{- end }}

{{- end }}
{{- end }}

{{- end }}