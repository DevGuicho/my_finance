# Ejemplo de uso del componente AreaChart
#
# En tu vista o controlador, puedes renderizar el componente así:
#
# Ejemplo básico:
# <%= render Dashboard::AreaChartComponent.new(
#   title: "Users",
#   value: "32.4k",
#   description: "Users this week",
#   percentage_change: 12,
#   trend: :up
# ) %>
#
# Ejemplo completo con datos personalizados:
# <%= render Dashboard::AreaChartComponent.new(
#   title: "Sales",
#   value: "$45.2k",
#   description: "Revenue this month",
#   percentage_change: 8.5,
#   trend: :up,
#   report_link: sales_report_path,
#   period_options: [
#     { label: "Yesterday", value: "yesterday" },
#     { label: "Last 7 days", value: "last_7_days" },
#     { label: "Last 30 days", value: "last_30_days" }
#   ],
#   chart_data: {
#     series: [
#       {
#         name: "Sales",
#         data: [4500, 4200, 4800, 5100, 4900, 5200, 5500]
#       }
#     ],
#     categories: [
#       "Monday", "Tuesday", "Wednesday", "Thursday",
#       "Friday", "Saturday", "Sunday"
#     ]
#   }
# ) %>
#
# Ejemplo con tendencia negativa:
# <%= render Dashboard::AreaChartComponent.new(
#   title: "Conversions",
#   value: "1.2k",
#   description: "Conversions this week",
#   percentage_change: 5,
#   trend: :down,
#   chart_data: {
#     series: [
#       {
#         name: "Conversions",
#         data: [1500, 1400, 1350, 1300, 1250, 1200, 1150]
#       }
#     ],
#     categories: ["Day 1", "Day 2", "Day 3", "Day 4", "Day 5", "Day 6", "Day 7"]
#   }
# ) %>
