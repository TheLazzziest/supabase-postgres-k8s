{{/*
Common labels
*/}}
{{- define "supabase-postgres.labels" -}}
helm.sh/chart: {{ include "supabase-postgres.chart" . }}
{{ include "supabase-postgres.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | replace "+" "_" | replace "-" "_" | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "supabase-postgres.selectorLabels" -}}
app.kubernetes.io/name: {{ include "supabase-postgres.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
