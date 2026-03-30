# Dashboard::AreaChartComponent

Un componente ViewComponent para renderizar gráficos de área usando ApexCharts con integración completa de Stimulus.

## Características

- ✅ Gráfico de área responsivo con ApexCharts 3.46.0
- ✅ Usa variables CSS para el color del brand (`--color-fg-brand`)
- ✅ Indicador de tendencia (arriba/abajo) con porcentaje
- ✅ Dropdown para filtros de período
- ✅ Enlace opcional a reporte
- ✅ Datos de gráfico personalizables
- ✅ IDs únicos para múltiples instancias en la misma página

## Uso

### Ejemplo Básico

```erb
<%= render Dashboard::AreaChartComponent.new(
  title: "Users",
  value: "32.4k",
  description: "Users this week",
  percentage_change: 12,
  trend: :up
) %>
```

### Ejemplo Completo

```erb
<%= render Dashboard::AreaChartComponent.new(
  title: "Sales",
  value: "$45.2k",
  description: "Revenue this month",
  percentage_change: 8.5,
  trend: :up,
  report_link: sales_report_path,
  period_options: [
    { label: "Yesterday", value: "yesterday" },
    { label: "Last 7 days", value: "last_7_days" },
    { label: "Last 30 days", value: "last_30_days" }
  ],
  chart_data: {
    series: [
      {
        name: "Sales",
        data: [4500, 4200, 4800, 5100, 4900, 5200, 5500]
      }
    ],
    categories: [
      "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"
    ]
  }
) %>
```

## Parámetros

| Parámetro | Tipo | Requerido | Default | Descripción |
|-----------|------|-----------|---------|-------------|
| `title` | String | ✅ | - | Título del gráfico (usado en el botón de reporte) |
| `value` | String | ✅ | - | Valor principal a mostrar (ej: "32.4k", "$45.2k") |
| `description` | String | ✅ | - | Descripción del valor (ej: "Users this week") |
| `percentage_change` | Number | ❌ | nil | Porcentaje de cambio a mostrar |
| `trend` | Symbol | ❌ | :up | Tendencia del cambio (`:up` o `:down`) |
| `period_options` | Array | ❌ | opciones default | Array de hashes con `label` y `value` para el dropdown |
| `report_link` | String | ❌ | nil | URL para el enlace del reporte |
| `chart_data` | Hash | ❌ | datos default | Datos del gráfico con `series` y `categories` |

### Estructura de `chart_data`

```ruby
{
  series: [
    {
      name: "Nombre de la serie",
      data: [valor1, valor2, valor3, ...]
    }
  ],
  categories: ["Etiqueta 1", "Etiqueta 2", "Etiqueta 3", ...]
}
```

## Personalización CSS

El componente usa la variable CSS `--color-fg-brand` para el color del gráfico. Puedes cambiar este valor en tu archivo de estilos:

```css
:root {
  --color-fg-brand: #1447E6;
}
```

## Archivos del Componente

- `app/components/dashboard/area_chart_component.rb` - Lógica del componente
- `app/components/dashboard/area_chart_component.html.erb` - Template HTML
- `app/javascript/controllers/area_chart_controller.js` - Stimulus controller para ApexCharts

## Dependencias

- ApexCharts 3.46.0 (configurado en `config/importmap.rb`)
- Stimulus (Hotwire)
- ViewComponent
- Flowbite (para el dropdown)

## Notas Técnicas

- El componente genera IDs únicos automáticamente para permitir múltiples instancias en la misma página
- El gráfico se inicializa automáticamente cuando el componente se conecta al DOM
- El gráfico se destruye automáticamente cuando el componente se desconecta del DOM
- Compatible con Turbo (no hay memory leaks)

