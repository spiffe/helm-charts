{{- define "spire-server.podSpec" }}
{{- $fullname := include "spire-server.fullname" . }}
{{- with .Values.imagePullSecrets }}
imagePullSecrets:
  {{- toYaml . | nindent 2 }}
{{- end }}
serviceAccountName: {{ include "spire-server.serviceAccountName" . }}
shareProcessNamespace: true
securityContext:
  {{- toYaml .Values.podSecurityContext | nindent 2 }}
initContainers:
{{- if and .Values.upstreamAuthority.certManager.enabled .Values.upstreamAuthority.certManager.ca.create }}
  - name: wait
    securityContext:
      {{- toYaml .Values.securityContext | nindent 6 }}
    image: {{ template "spire-lib.kubectl-image" (dict "appVersion" $.Chart.AppVersion "image" .Values.tools.kubectl.image "global" .Values.global "KubeVersion" .Capabilities.KubeVersion.Version) }}
    args:
      - wait
      - --namespace
      - {{ .Release.Namespace }}
      - --timeout=3m
      - --for=condition=ready
      - issuer
      - {{ include "spire-server.fullname" $ }}
    imagePullPolicy: {{ .Values.tools.kubectl.image.pullPolicy }}
{{- end }}
{{- if gt (len .Values.initContainers) 0 }}
  {{- toYaml .Values.initContainers | nindent 2 }}
{{- end }}
containers:
  - name: {{ .Chart.Name }}
    securityContext:
      {{- toYaml .Values.securityContext | nindent 6 }}
    image: {{ template "spire-lib.image" (dict "appVersion" $.Chart.AppVersion "image" .Values.image "global" .Values.global) }}
    imagePullPolicy: {{ .Values.image.pullPolicy }}
    args:
      - -expandEnv
      - -config
      - /run/spire/config/server.conf
    env:
    - name: PATH
      value: "/opt/spire/bin:/bin"
    {{- if ne .Values.dataStore.sql.databaseType "sqlite3" }}
    - name: DBPW
      valueFrom:
        secretKeyRef:
          name: {{ $fullname }}-dbpw
          key: DBPW
    {{- end }}
    ports:
      - name: grpc
        containerPort: 8081
        protocol: TCP
      - containerPort: 8080
        name: healthz
      {{- with .Values.federation }}
      {{- if eq (.enabled | toString) "true" }}
      - name: federation
        containerPort: {{ .bundleEndpoint.port }}
        protocol: TCP
      {{- end }}
      {{- end }}
      {{- if (dig "telemetry" "prometheus" "enabled" .Values.telemetry.prometheus.enabled .Values.global) }}
      - containerPort: 9988
        name: prom
      {{- end }}
    livenessProbe:
      httpGet:
        path: /live
        port: healthz
      {{- toYaml .Values.livenessProbe | nindent 6 }}
    readinessProbe:
      httpGet:
        path: /ready
        port: healthz
      {{- toYaml .Values.readinessProbe | nindent 6 }}
    resources:
      {{- toYaml .Values.resources | nindent 6 }}
    volumeMounts:
      - name: spire-server-socket
        mountPath: /tmp/spire-server/private
        readOnly: false
      - name: spire-config
        mountPath: /run/spire/config
        readOnly: true
      - name: spire-data
        mountPath: /run/spire/data
        readOnly: false
      {{- if eq (.Values.upstreamAuthority.disk.enabled | toString) "true" }}
      - name: upstream-ca
        mountPath: /run/spire/upstream_ca
        readOnly: false
      {{ end }}
      {{- if gt (len .Values.extraVolumeMounts) 0 }}
      {{- toYaml .Values.extraVolumeMounts | nindent 6 }}
      {{- end }}
  {{- if eq (.Values.controllerManager.enabled | toString) "true" }}
  - name: spire-controller-manager
    securityContext:
      {{- toYaml .Values.controllerManager.securityContext | nindent 6 }}
    image: {{ template "spire-lib.image" (dict "appVersion" $.Chart.AppVersion "image" .Values.controllerManager.image "global" .Values.global) }}
    imagePullPolicy: {{ .Values.controllerManager.image.pullPolicy }}
    args:
      - --config=controller-manager-config.yaml
    ports:
      - name: https
        containerPort: 9443
        protocol: TCP
      - containerPort: 8083
        name: healthz
      {{- if (dig "telemetry" "prometheus" "enabled" .Values.telemetry.prometheus.enabled .Values.global) }}
      - containerPort: 8082
        name: prom2
      {{- end }}
    livenessProbe:
      httpGet:
        path: /healthz
        port: healthz
    readinessProbe:
      httpGet:
        path: /readyz
        port: healthz
    resources:
      {{- toYaml .Values.controllerManager.resources | nindent 6 }}
    volumeMounts:
      - name: spire-server-socket
        mountPath: /tmp/spire-server/private
        readOnly: true
      - name: controller-manager-config
        mountPath: /controller-manager-config.yaml
        subPath: controller-manager-config.yaml
        readOnly: true
      - name: spire-controller-manager-tmp
        mountPath: /tmp
        readOnly: false
  {{- end }}

  {{- if eq (.Values.tornjak.enabled | toString) "true" }}
  - name: tornjak
    securityContext:
      {{- toYaml .Values.controllerManager.securityContext | nindent 6 }}
    image: {{ template "spire-lib.image" (dict "appVersion" $.Chart.AppVersion "image" .Values.tornjak.image "global" .Values.global) }}
    imagePullPolicy: {{ .Values.tornjak.image.pullPolicy }}
    {{- if eq (include "spire-tornjak.connectionType" .) "http" }}
    startupProbe:
      httpGet:
        scheme: HTTP
        path: /api/tornjak/serverinfo
        port: 10080
      {{- toYaml .Values.tornjak.startupProbe | nindent 6 }}
    {{- end }}
    args:
      - --spire-config
      - /run/spire/config/server.conf
      - --tornjak-config
      - /run/spire/tornjak-config/server.conf
    ports:
      - name: tornjak-http
        containerPort: 10080
        protocol: TCP
      - name: tornjak-https
        containerPort: 10443
        protocol: TCP
    resources:
      {{- toYaml .Values.tornjak.resources | nindent 6 }}
    volumeMounts:
      - name: {{ include "spire-tornjak.config" . }}
        mountPath: /run/spire/tornjak-config
      - name: spire-server-socket
        mountPath: /tmp/spire-server/private
        readOnly: true
      - name: spire-config
        mountPath: /run/spire/config
        readOnly: true
      - name: spire-data
        mountPath: /run/spire/data
        readOnly: false
      {{- if or (eq (include "spire-tornjak.connectionType" .) "tls") (eq (include "spire-tornjak.connectionType" .) "mtls") }}
      - name: server-cert
        mountPath: /opt/spire/server
      {{- end }}
      {{- if eq (include "spire-tornjak.connectionType" .) "mtls" }}
      - name: user-cert
        mountPath: /opt/spire/user
      {{- end }}
  {{- end }}

  {{- if gt (len .Values.extraContainers) 0 }}
  {{- toYaml .Values.extraContainers | nindent 2 }}
  {{- end }}
{{- with .Values.nodeSelector }}
nodeSelector:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.affinity }}
affinity:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.tolerations }}
tolerations:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with .Values.topologySpreadConstraints }}
topologySpreadConstraints:
  {{- toYaml . | nindent 2 }}
{{- end }}
volumes:
  - name: spire-config
    configMap:
      name: {{ include "spire-server.fullname" . }}
  - name: spire-server-socket
    emptyDir: {}
  - name: spire-controller-manager-tmp
    emptyDir: {}
  {{- if or (eq (include "spire-tornjak.connectionType" .) "tls") (eq (include "spire-tornjak.connectionType" .) "mtls") }}
  - name: server-cert
    secret:
      defaultMode: 256
      secretName: {{ .Values.tornjak.config.tlsSecret }}
  {{- end }}
  {{- if eq (include "spire-tornjak.connectionType" .) "mtls" }}
  {{- if eq .Values.tornjak.config.clientCA.type "Secret" }}
  - name: user-cert
    secret:
      defaultMode: 256
      secretName: {{ .Values.tornjak.config.clientCA.name }}
  {{- else if eq .Values.tornjak.config.clientCA.type "ConfigMap" }}
  - name: user-cert
    configMap:
      name: {{ .Values.tornjak.config.clientCA.name }}
  {{- end }}
  {{- end }}
  {{- if eq (.Values.upstreamAuthority.disk.enabled | toString) "true" }}
  - name: upstream-ca
    secret:
      secretName: {{ include "spire-server.upstream-ca-secret" . }}
  {{- end }}
  {{- if eq (.Values.controllerManager.enabled | toString) "true" }}
  - name: controller-manager-config
    configMap:
      name: {{ include "spire-controller-manager.fullname" . }}
  {{- end }}
  {{- if eq (.Values.tornjak.enabled | toString) "true" }}
  {{- if .Values.tornjak.config }}
  - name: {{ include "spire-tornjak.config" . }}
    configMap:
      defaultMode: 420
      name: {{ include "spire-tornjak.config" . }}
  {{- end }}
  {{- end }}
  {{- if gt (len .Values.extraVolumes) 0 }}
  {{- toYaml .Values.extraVolumes | nindent 2 }}
  {{- end }}
