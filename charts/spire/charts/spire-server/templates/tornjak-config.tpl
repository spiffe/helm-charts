{{- if eq (.Values.tornjak.enabled | toString) "true" }}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "spire-tornjak.config" . }}
  namespace: {{ include "spire-server.namespace" . }}
data:
  server.conf: |
    server {
      metadata = "insert metadata"
    }

    plugins {
    {{- if .Values.tornjak.config }}
    {{- if .Values.tornjak.config.backend }}
    {{- if .Values.tornjak.config.backend.dataStore }}
      DataStore "sql" {
        plugin_data {
          drivername = "{{ .Values.tornjak.config.backend.dataStore.driver }}"
          filename = "{{ .Values.tornjak.config.backend.dataStore.file }}"
        }
      }
    {{- end }}
    {{- end }}
    {{- end }}
    }
    {{- end }}