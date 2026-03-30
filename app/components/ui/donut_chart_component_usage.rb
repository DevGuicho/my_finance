# frozen_string_literal: true

# Este archivo muestra ejemplos de cómo usar el DonutChartComponent
# No es necesario incluirlo en tu aplicación, es solo para referencia

module Examples
  class DonutChartComponentUsage
    # Ejemplo básico con datos de categorías de gastos
    def self.basic_example
      # En tu vista ERB:
      # <%= render Ui::DonutChartComponent.new(
      #   series: [44, 55, 13, 33],
      #   labels: ["Alimentos", "Transporte", "Entretenimiento", "Servicios"]
      # ) %>
    end

    # Ejemplo con colores personalizados
    def self.custom_colors_example
      # <%= render Ui::DonutChartComponent.new(
      #   series: [1244, 785, 433, 267],
      #   labels: ["Alimentos", "Transporte", "Entretenimiento", "Servicios"],
      #   colors: ["#FF6384", "#36A2EB", "#FFCE56", "#4BC0C0"]
      # ) %>
    end

    # Ejemplo con altura personalizada
    def self.custom_height_example
      # <%= render Ui::DonutChartComponent.new(
      #   series: [44, 55, 13, 33],
      #   labels: ["Alimentos", "Transporte", "Entretenimiento", "Servicios"],
      #   height: "350px",
      #   max_width: "100%"
      # ) %>
    end

    # Ejemplo con opciones personalizadas del chart
    def self.custom_options_example
      # <%= render Ui::DonutChartComponent.new(
      #   series: [44, 55, 13, 33],
      #   labels: ["Alimentos", "Transporte", "Entretenimiento", "Servicios"],
      #   chart_options: {
      #     legend: {
      #       position: "right"
      #     },
      #     plotOptions: {
      #       pie: {
      #         donut: {
      #           size: "70%"
      #         }
      #       }
      #     }
      #   }
      # ) %>
    end

    # Ejemplo con datos dinámicos de categorías
    def self.dynamic_categories_example
      # En tu controlador:
      # @category_spending = Category.joins(:transactions)
      #                               .where(transactions: { transaction_type: 'expense' })
      #                               .group(:name)
      #                               .sum('transactions.amount')
      #
      # En tu vista ERB:
      # <%= render Ui::DonutChartComponent.new(
      #   series: @category_spending.values.map(&:to_f),
      #   labels: @category_spending.keys
      # ) %>
    end

    # Ejemplo completo en un card como en el dashboard
    def self.in_card_example
      # <%= render Ui::CardComponent.new(class: "flex-1/3") do %>
      #   <h6 class="text-md mb-1">Gastos por Categoría</h6>
      #   <p class="text-body-subtle text-sm mb-4">Este mes</p>
      #
      #   <%= render Ui::DonutChartComponent.new(
      #     series: [1244, 785, 433, 267],
      #     labels: ["Alimentos", "Transporte", "Entretenimiento", "Servicios"],
      #     height: "300px"
      #   ) %>
      # <% end %>
    end
  end
end
