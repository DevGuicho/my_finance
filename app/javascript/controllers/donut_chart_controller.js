import { Controller } from "@hotwired/stimulus"
import ApexCharts from "apexcharts"

// Connects to data-controller="donut-chart"
export default class extends Controller {
  static targets = ["chart"]
  static values = {
    options: Object
  }

  connect() {
    this.initializeChart()
  }

  disconnect() {
    if (this.chart) {
      this.chart.destroy()
    }
  }

  initializeChart() {
    if (typeof ApexCharts === 'undefined') {
      console.error('ApexCharts is not loaded')
      return
    }

    const chartOptions = this.buildChartOptions()

    this.chart = new ApexCharts(this.chartTarget, chartOptions)
    this.chart.render()
  }

  getBrandColor() {
    // Get the computed style of the document's root element
    const computedStyle = getComputedStyle(document.documentElement)
    
    // Get the value of the --color-fg-brand CSS variable
    return computedStyle.getPropertyValue('--color-fg-brand').trim() || "#1447E6"
  }

  getDefaultColors() {
    // Default color palette for donut charts
    return [
      this.getBrandColor(),
      "#16BDCA", // Teal
      "#FDBA8C", // Orange
      "#E74694", // Pink
      "#1C64F2", // Blue
      "#9061F9", // Purple
      "#31C48D", // Green
      "#F98080", // Red
    ]
  }

  buildChartOptions() {
    const { 
      series, 
      labels, 
      height, 
      maxWidth, 
      colors,
      customOptions 
    } = this.optionsValue

    // Use provided colors or fall back to default colors
    const chartColors = colors || this.getDefaultColors()

    // Default options
    const defaultOptions = {
      chart: {
        height: height || "100%",
        maxWidth: maxWidth || "100%",
        type: "donut",
        fontFamily: "Inter, sans-serif",
        toolbar: {
          show: false,
        },
      },
      series: series || [],
      labels: labels || [],
      colors: chartColors,
      stroke: {
        colors: ["transparent"],
        lineCap: "",
      },
      plotOptions: {
        pie: {
          donut: {
            labels: {
              show: true,
              name: {
                show: true,
                fontFamily: "Inter, sans-serif",
                offsetY: 20,
              },
              total: {
                showAlways: true,
                show: true,
                label: "Total",
                fontFamily: "Inter, sans-serif",
                formatter: function (w) {
                  const sum = w.globals.seriesTotals.reduce((a, b) => {
                    return a + b
                  }, 0)
                  return sum.toLocaleString()
                },
              },
              value: {
                show: true,
                fontFamily: "Inter, sans-serif",
                offsetY: -20,
                formatter: function (value) {
                  return value.toLocaleString()
                },
              },
            },
            size: "80%",
          },
        },
      },
      grid: {
        padding: {
          top: -2,
        },
      },
      dataLabels: {
        enabled: false,
      },
      legend: {
        position: "bottom",
        fontFamily: "Inter, sans-serif",
      },
      tooltip: {
        enabled: true,
        y: {
          formatter: function (value) {
            return value.toLocaleString()
          },
        },
      },
    }

    // Deep merge custom options with defaults
    return this.deepMerge(defaultOptions, customOptions || {})
  }

  deepMerge(target, source) {
    const output = Object.assign({}, target)
    if (this.isObject(target) && this.isObject(source)) {
      Object.keys(source).forEach(key => {
        if (this.isObject(source[key])) {
          if (!(key in target))
            Object.assign(output, { [key]: source[key] })
          else
            output[key] = this.deepMerge(target[key], source[key])
        } else {
          Object.assign(output, { [key]: source[key] })
        }
      })
    }
    return output
  }

  isObject(item) {
    return item && typeof item === 'object' && !Array.isArray(item)
  }
}

