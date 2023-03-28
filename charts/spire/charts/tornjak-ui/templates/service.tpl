{{- if eq (.Values.tornjakFrontend.enabled | toString) "true" }}
apiVersion: v1
kind: Service
metadata:
  namespace: {{ include "tornjak-frontend.namespace" . }}
  name: {{ include "tornjak-frontend.service" . }}
  labels:
    {{- include "tornjak-frontend.labels" . | nindent 4 }}
spec:
  type: {{ .Values.service.type }}
  selector:
    {{- include "tornjak-frontend.selectorLabels" . | nindent 4 }}
  ports:
    - name: {{ include "tornjak-frontend.fullname" . }}
      port: {{ .Values.service.port }}
      targetPort: 3000
{{- end }}