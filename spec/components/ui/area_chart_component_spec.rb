# frozen_string_literal: true

require "rails_helper"

RSpec.describe Ui::AreaChartComponent, type: :component do
  it "renders with minimum required parameters" do
    render_inline(described_class.new(
      series: [{ name: "Users", data: [100, 200, 300] }]
    ))

    expect(page).to have_css("[data-controller='area-chart']")
    expect(page).to have_css("[data-area-chart-target='chart']")
  end

  it "generates unique chart id" do
    component1 = described_class.new(series: [{ name: "Data", data: [1, 2, 3] }])
    component2 = described_class.new(series: [{ name: "Data", data: [1, 2, 3] }])

    expect(component1.chart_id).not_to eq(component2.chart_id)
  end

  it "renders with categories" do
    render_inline(described_class.new(
      series: [{ name: "Sales", data: [100, 200, 300] }],
      categories: ["Jan", "Feb", "Mar"]
    ))

    expect(page).to have_css("[data-area-chart-options-value]")
  end

  it "renders with custom color" do
    render_inline(described_class.new(
      series: [{ name: "Revenue", data: [1000, 2000, 3000] }],
      color: "#10b981"
    ))

    expect(page).to have_css("[data-controller='area-chart']")
  end

  it "renders with custom dimensions" do
    render_inline(described_class.new(
      series: [{ name: "Data", data: [1, 2, 3] }],
      height: "350px",
      max_width: "600px"
    ))

    expect(page).to have_css("[data-area-chart-options-value]")
  end

  it "renders with custom stroke width" do
    render_inline(described_class.new(
      series: [{ name: "Data", data: [1, 2, 3] }],
      stroke_width: 4
    ))

    expect(page).to have_css("[data-controller='area-chart']")
  end

  it "renders with custom chart options" do
    render_inline(described_class.new(
      series: [{ name: "Data", data: [1, 2, 3] }],
      chart_options: {
        tooltip: { enabled: false },
        grid: { show: true }
      }
    ))

    expect(page).to have_css("[data-area-chart-options-value]")
  end

  it "includes all data in the options value" do
    component = described_class.new(
      series: [{ name: "Users", data: [100, 200, 300] }],
      categories: ["A", "B", "C"],
      height: "400px",
      max_width: "800px",
      color: "#ff0000",
      stroke_width: 8
    )

    render_inline(component)
    
    data = JSON.parse(component.chart_data)
    
    expect(data["series"]).to eq([{ "name" => "Users", "data" => [100, 200, 300] }])
    expect(data["categories"]).to eq(["A", "B", "C"])
    expect(data["height"]).to eq("400px")
    expect(data["maxWidth"]).to eq("800px")
    expect(data["color"]).to eq("#ff0000")
    expect(data["strokeWidth"]).to eq(8)
  end

  it "handles multiple series" do
    render_inline(described_class.new(
      series: [
        { name: "Series 1", data: [1, 2, 3] },
        { name: "Series 2", data: [4, 5, 6] }
      ],
      categories: ["X", "Y", "Z"]
    ))

    expect(page).to have_css("[data-controller='area-chart']")
  end

  it "works without categories" do
    render_inline(described_class.new(
      series: [{ name: "Data", data: [10, 20, 30, 40, 50] }]
    ))

    expect(page).to have_css("[data-controller='area-chart']")
  end
end

