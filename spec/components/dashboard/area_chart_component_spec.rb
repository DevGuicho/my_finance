# frozen_string_literal: true

require "rails_helper"

RSpec.describe Dashboard::AreaChartComponent, type: :component do
  it "renders with required parameters" do
    render_inline(described_class.new(
      title: "Users",
      value: "32.4k",
      description: "Users this week"
    ))

    expect(page).to have_text("32.4k")
    expect(page).to have_text("Users this week")
  end

  it "renders with percentage change and trend" do
    render_inline(described_class.new(
      title: "Sales",
      value: "$45.2k",
      description: "Revenue this month",
      percentage_change: 12,
      trend: :up
    ))

    expect(page).to have_text("12%")
    expect(page).to have_css(".text-fg-success")
  end

  it "renders with down trend" do
    render_inline(described_class.new(
      title: "Losses",
      value: "$1.2k",
      description: "Losses this week",
      percentage_change: 5,
      trend: :down
    ))

    expect(page).to have_text("5%")
    expect(page).to have_css(".text-fg-destructive")
  end

  it "renders chart container with unique id" do
    component = described_class.new(
      title: "Users",
      value: "32.4k",
      description: "Users this week"
    )

    render_inline(component)

    expect(page).to have_css("[data-area-chart-target='chart']")
    expect(page).to have_css("[data-controller='area-chart']")
  end

  it "renders period options dropdown" do
    render_inline(described_class.new(
      title: "Users",
      value: "32.4k",
      description: "Users this week",
      period_options: [
        { label: "Today", value: "today" },
        { label: "Yesterday", value: "yesterday" }
      ]
    ))

    expect(page).to have_text("Today")
    expect(page).to have_text("Yesterday")
  end

  it "renders report link when provided" do
    render_inline(described_class.new(
      title: "Users",
      value: "32.4k",
      description: "Users this week",
      report_link: "/reports/users"
    ))

    expect(page).to have_link("Users Report", href: "/reports/users")
  end

  it "includes chart data in data attribute" do
    component = described_class.new(
      title: "Users",
      value: "32.4k",
      description: "Users this week",
      chart_data: {
        series: [{ name: "Users", data: [100, 200, 300] }],
        categories: ["Day 1", "Day 2", "Day 3"]
      }
    )

    render_inline(component)

    expect(page).to have_css("[data-area-chart-options-value]")
  end
end

