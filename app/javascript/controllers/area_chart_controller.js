import { Controller } from "@hotwired/stimulus"
import ApexCharts from "apexcharts"

// Connects to data-controller="area-chart"
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

  buildChartOptions() {
    const { 
      series, 
      categories, 
      height, 
      maxWidth, 
      color, 
      strokeWidth,
      customOptions 
    } = this.optionsValue

    // Use provided color or fall back to brand color
    const chartColor = color || this.getBrandColor()

    // Default options
    const defaultOptions = {
      chart: {
        height: height || "100%",
        maxWidth: maxWidth || "100%",
        type: "area",
        fontFamily: "Inter, sans-serif",
        dropShadow: {
          enabled: false,
        },
        toolbar: {
          show: false,
        },
      },
      tooltip: {
        enabled: true,
        x: {
          show: false,
        },
      },
      fill: {
        type: "gradient",
        gradient: {
          opacityFrom: 0.55,
          opacityTo: 0,
          shade: chartColor,
          gradientToColors: [chartColor],
        },
      },
      dataLabels: {
        enabled: false,
      },
      stroke: {
        width: strokeWidth || 6,
      },
      grid: {
        show: false,
        strokeDashArray: 4,
        padding: {
          left: 2,
          right: 2,
          top: 0
        },
      },
      series: series.map(s => ({
        ...s,
        color: chartColor
      })),
      xaxis: {
        categories: categories || [],
        labels: {
          show: false,
        },
        axisBorder: {
          show: false,
        },
        axisTicks: {
          show: false,
        },
      },
      yaxis: {
        show: false,
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

