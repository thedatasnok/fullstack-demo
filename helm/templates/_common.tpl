{{- define "chart.labels" -}}
chart: "{{ .Chart.Name }}-{{ .Chart.Version }}"
{{- end -}}

{{- define "backend.name" -}}
{{- printf "%s-%s" .Chart.Name "backend" -}}
{{- end -}}

{{- define "frontend.name" -}}
{{- printf "%s-%s" .Chart.Name "frontend" -}}
{{- end -}}
