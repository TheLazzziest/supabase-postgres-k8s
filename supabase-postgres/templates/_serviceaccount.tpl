{{/*
Create the name of the service account to use
*/}}
{{- define "supabase-postgres.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "supabase-postgres.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
