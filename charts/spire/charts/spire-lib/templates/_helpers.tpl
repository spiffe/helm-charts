
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
