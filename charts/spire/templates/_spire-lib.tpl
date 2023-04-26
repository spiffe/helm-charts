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
