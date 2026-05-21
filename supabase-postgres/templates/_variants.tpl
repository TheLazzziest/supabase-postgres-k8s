{{/*
Select the correct image based on the active variant
*/}}
{{- define "supabase-postgres.image" -}}
{{- $vc := index .Values.variants .Values.variant | default .Values.variants.postgres }}
{{- printf "%s:%s" $vc.image.repository $vc.image.tag }}
{{- end }}
