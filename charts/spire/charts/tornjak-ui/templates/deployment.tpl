{{- if eq (.Values.tornjakFrontend.enabled | toString) "true" }}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "tornjak-frontend.fullname" . }}
  namespace: {{ include "tornjak-frontend.namespace" . }}
  labels:
    {{- include "tornjak-frontend.labels" . | nindent 4 }}
spec:
  replicas: 1
  selector:
    matchLabels:
      {{- include "tornjak-frontend.selectorLabels" . | nindent 6 }}
  template:
    metadata:
      labels:
        {{- include "tornjak-frontend.selectorLabels" . | nindent 8 }}
    spec:
      shareProcessNamespace: true
      serviceAccountName: {{ include "tornjak-frontend.serviceAccountName" . }}   
      containers:
      - name:  {{ include "tornjak-frontend.fullname" . }}
        image: {{ template "tornjak-frontend.image" (dict "appVersion" $.Chart.AppVersion "image" .Values.image) }}
        imagePullPolicy: {{ .Values.image.pullPolicy }}
        ports:
        - containerPort: {{ .Values.service.port }}
        env:
        - name: REACT_APP_API_SERVER_URI
          value: {{ .Values.tornjakFrontend.apiServerURL }}          
        startupProbe:
          httpGet:
            scheme: HTTP
            port: {{ .Values.service.port }} 
          failureThreshold: 6
          initialDelaySeconds: 60
          periodSeconds: 30
          successThreshold: 1
          timeoutSeconds: 10
{{- end }}