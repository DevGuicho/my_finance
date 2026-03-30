# Ui::AreaChartComponent

Un componente ViewComponent reutilizable y altamente customizable para renderizar gráficos de área usando ApexCharts 3.46.0.

## Características

- ✅ Componente UI puro, sin lógica de negocio
- ✅ Altamente customizable con opciones de ApexCharts
- ✅ Color automático desde variable CSS `--color-fg-brand` o personalizado
- ✅ Deep merge de opciones personalizadas
- ✅ IDs únicos para múltiples instancias
- ✅ Compatible con Turbo (auto-cleanup)

## Uso

### Ejemplo Básico

```erb
<%= render Ui::AreaChartComponent.new(
  series: [
    { name: "Users", data: [100, 200, 150, 300, 250, 400] }
  ],
  categories: ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
) %>
```

### Ejemplo con Color Personalizado

```erb
<%= render Ui::AreaChartComponent.new(
  series: [
    { name: "Revenue", data: [5000, 6000, 5500, 7000, 6500, 8000] }
  ],
  categories: ["Week 1", "Week 2", "Week 3", "Week 4", "Week 5", "Week 6"],
  color: "#10b981"
) %>
```

### Ejemplo con Dimensiones Personalizadas

```erb
<%= render Ui::AreaChartComponent.new(
  series: [
    { name: "Sales", data: [10, 20, 15, 30, 25, 40] }
  ],
  categories: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
  height: "350px",
  max_width: "600px",
  stroke_width: 4
) %>
```

### Ejemplo con Opciones Avanzadas de ApexCharts

```erb
<%= render Ui::AreaChartComponent.new(
  series: [
    { name: "Temperature", data: [22, 24, 23, 25, 26, 24, 23] }
  ],
  categories: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
  chart_options: {
    tooltip: {
      enabled: true,
      x: { show: true },
      y: {
        formatter: "(value) => value + '°C'"
      }
    },
    grid: {
      show: true,
      borderColor: '#e0e0e0'
    },
    yaxis: {
      show: true,
      labels: {
        formatter: "(value) => value + '°C'"
      }
    },
    xaxis: {
      labels: { show: true }
    }
  }
) %>
```

### Ejemplo Standalone (sin wrapper)

```erb
<div class="p-4 bg-white rounded-lg shadow">
  <h3 class="text-lg font-semibold mb-4">Monthly Revenue</h3>
  <%= render Ui::AreaChartComponent.new(
    series: [
      { name: "Revenue", data: [45000, 52000, 48000, 61000, 58000, 65000] }
    ],
    categories: ["Jan", "Feb", "Mar", "Apr", "May", "Jun"],
    height: "300px"
  ) %>
</div>
```

## Parámetros

| Parámetro | Tipo | Requerido | Default | Descripción |
|-----------|------|-----------|---------|-------------|
| `series` | Array | ✅ | - | Array de objetos con `name` y `data` |
| `categories` | Array | ❌ | [] | Etiquetas del eje X |
| `height` | String | ❌ | "100%" | Altura del gráfico |
| `max_width` | String | ❌ | "100%" | Ancho máximo del gráfico |
| `color` | String | ❌ | nil | Color hexadecimal (si nil, usa `--color-fg-brand`) |
| `stroke_width` | Integer | ❌ | 6 | Grosor de la línea |
| `chart_options` | Hash | ❌ | {} | Opciones personalizadas de ApexCharts |

### Estructura de `series`

```ruby
[
  {
    name: "Nombre de la serie",
    data: [valor1, valor2, valor3, ...]
  }
]
```

### Opciones de `chart_options`

Puedes pasar cualquier opción válida de ApexCharts. Las opciones personalizadas se fusionan profundamente con las opciones por defecto.

Opciones comunes:
- `tooltip`: Configuración del tooltip
- `grid`: Configuración de la cuadrícula
- `xaxis`: Configuración del eje X
- `yaxis`: Configuración del eje Y
- `dataLabels`: Configuración de etiquetas de datos
- `fill`: Configuración de relleno/gradiente

Ver la [documentación de ApexCharts](https://apexcharts.com/docs/options/) para todas las opciones disponibles.

## Opciones por Defecto

```javascript
{
  chart: {
    type: "area",
    fontFamily: "Inter, sans-serif",
    dropShadow: { enabled: false },
    toolbar: { show: false }
  },
  tooltip: {
    enabled: true,
    x: { show: false }
  },
  fill: {
    type: "gradient",
    gradient: {
      opacityFrom: 0.55,
      opacityTo: 0,
      shade: color,
      gradientToColors: [color]
    }
  },
  dataLabels: { enabled: false },
  grid: {
    show: false,
    strokeDashArray: 4,
    padding: { left: 2, right: 2, top: 0 }
  },
  xaxis: {
    labels: { show: false },
    axisBorder: { show: false },
    axisTicks: { show: false }
  },
  yaxis: { show: false }
}
```

## Ejemplos de Integración

### Dentro de un Card Dashboard

```erb
<div class="bg-white rounded-lg shadow p-6">
  <div class="flex justify-between items-start mb-4">
    <div>
      <h3 class="text-2xl font-bold">$45.2k</h3>
      <p class="text-gray-600">Total Revenue</p>
    </div>
    <span class="text-green-600 font-semibold">+12%</span>
  </div>
  
  <%= render Ui::AreaChartComponent.new(
    series: [{ name: "Revenue", data: [30000, 35000, 32000, 40000, 38000, 45000] }],
    categories: ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
  ) %>
</div>
```

### Grid de Múltiples Gráficos

```erb
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
  <div class="bg-white p-4 rounded shadow">
    <h4 class="font-semibold mb-2">Users</h4>
    <%= render Ui::AreaChartComponent.new(
      series: [{ name: "Users", data: [100, 150, 120, 180, 160, 200] }],
      categories: ["W1", "W2", "W3", "W4", "W5", "W6"],
      height: "200px",
      color: "#3b82f6"
    ) %>
  </div>
  
  <div class="bg-white p-4 rounded shadow">
    <h4 class="font-semibold mb-2">Sales</h4>
    <%= render Ui::AreaChartComponent.new(
      series: [{ name: "Sales", data: [50, 60, 55, 70, 65, 80] }],
      categories: ["W1", "W2", "W3", "W4", "W5", "W6"],
      height: "200px",
      color: "#10b981"
    ) %>
  </div>
  
  <div class="bg-white p-4 rounded shadow">
    <h4 class="font-semibold mb-2">Orders</h4>
    <%= render Ui::AreaChartComponent.new(
      series: [{ name: "Orders", data: [30, 40, 35, 50, 45, 60] }],
      categories: ["W1", "W2", "W3", "W4", "W5", "W6"],
      height: "200px",
      color: "#f59e0b"
    ) %>
  </div>
</div>
```

## Archivos

- `app/components/ui/area_chart_component.rb` - Lógica del componente
- `app/components/ui/area_chart_component.html.erb` - Template HTML
- `app/javascript/controllers/area_chart_controller.js` - Stimulus controller

## Dependencias

- ApexCharts 3.46.0
- Stimulus (Hotwire)
- ViewComponent

## Notas Técnicas

- Genera IDs únicos automáticamente
- Compatible con Turbo (destruye el gráfico al desconectarse)
- Deep merge de opciones permite sobreescribir cualquier configuración por defecto
- Si no se proporciona `color`, usa la variable CSS `--color-fg-brand`

