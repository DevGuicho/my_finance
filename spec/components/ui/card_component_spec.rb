# frozen_string_literal: true

require "rails_helper"

RSpec.describe Ui::CardComponent, type: :component do
  it "renders with default classes" do
    render_inline(described_class.new) do
      "Test content"
    end

    expect(page).to have_css("div.bg-neutral-primary-soft")
    expect(page).to have_css("div.p-6")
    expect(page).to have_css("div.shadow-xs")
    expect(page).to have_css("div.rounded-base")
    expect(page).to have_css("div.border")
    expect(page).to have_text("Test content")
  end

  it "renders with custom classes" do
    render_inline(described_class.new(class: "custom-class hover:shadow-lg")) do
      "Content"
    end

    expect(page).to have_css("div.custom-class")
    expect(page).to have_css("div.hover\\:shadow-lg")
  end

  it "renders without border when border is false" do
    render_inline(described_class.new(border: false)) do
      "Content"
    end

    expect(page).not_to have_css("div.border")
  end

  it "renders with custom padding" do
    render_inline(described_class.new(padding: "p-8")) do
      "Content"
    end

    expect(page).to have_css("div.p-8")
    expect(page).not_to have_css("div.p-6")
  end

  it "renders without padding when padding is nil" do
    render_inline(described_class.new(padding: nil)) do
      "Content"
    end

    expect(page).not_to have_css("div.p-6")
  end

  it "renders with custom shadow" do
    render_inline(described_class.new(shadow: "shadow-lg")) do
      "Content"
    end

    expect(page).to have_css("div.shadow-lg")
  end

  it "renders without shadow when shadow is nil" do
    render_inline(described_class.new(shadow: nil)) do
      "Content"
    end

    expect(page).not_to have_css("div.shadow-xs")
  end

  it "renders with custom rounded" do
    render_inline(described_class.new(rounded: "rounded-xl")) do
      "Content"
    end

    expect(page).to have_css("div.rounded-xl")
  end

  it "renders without rounded when rounded is nil" do
    render_inline(described_class.new(rounded: nil)) do
      "Content"
    end

    expect(page).not_to have_css("div.rounded-base")
  end

  it "renders with custom background" do
    render_inline(described_class.new(background: "bg-white")) do
      "Content"
    end

    expect(page).to have_css("div.bg-white")
    expect(page).not_to have_css("div.bg-neutral-primary-soft")
  end

  it "renders with custom width" do
    render_inline(described_class.new(width: "w-full")) do
      "Content"
    end

    expect(page).to have_css("div.w-full")
  end

  it "renders with custom max_width" do
    render_inline(described_class.new(max_width: "max-w-2xl")) do
      "Content"
    end

    expect(page).to have_css("div.max-w-2xl")
  end

  it "renders with custom HTML attributes" do
    render_inline(described_class.new(id: "my-card")) do
      "Content"
    end

    expect(page).to have_css("div#my-card")
  end

  it "renders with data attributes" do
    render_inline(described_class.new(data: { controller: "card", action: "click" })) do
      "Content"
    end

    expect(page).to have_css("div[data-controller='card']")
    expect(page).to have_css("div[data-action='click']")
  end

  it "combines multiple custom options" do
    render_inline(described_class.new(
      class: "custom-class",
      padding: "p-8",
      shadow: "shadow-lg",
      border: false,
      rounded: "rounded-xl",
      background: "bg-white",
      width: "w-full",
      max_width: "max-w-4xl",
      id: "test-card"
    )) do
      "Content"
    end

    expect(page).to have_css("div#test-card.custom-class.p-8.shadow-lg.rounded-xl.bg-white.w-full.max-w-4xl")
    expect(page).not_to have_css("div.border")
  end

  it "renders content block" do
    render_inline(described_class.new) do
      "<h1>Title</h1><p>Description</p>".html_safe
    end

    expect(page).to have_css("h1", text: "Title")
    expect(page).to have_css("p", text: "Description")
  end

  it "handles nil values gracefully" do
    render_inline(described_class.new(
      padding: nil,
      shadow: nil,
      rounded: nil,
      background: nil,
      max_width: nil,
      width: nil
    )) do
      "Content"
    end

    # Should still render the div with border
    expect(page).to have_css("div.border")
    expect(page).to have_text("Content")
  end

  describe "#component_classes" do
    it "joins all classes correctly" do
      component = described_class.new(
        class: "custom",
        padding: "p-4",
        shadow: "shadow-md",
        rounded: "rounded-lg",
        background: "bg-white"
      )

      expect(component.component_classes).to include("custom")
      expect(component.component_classes).to include("p-4")
      expect(component.component_classes).to include("shadow-md")
      expect(component.component_classes).to include("rounded-lg")
      expect(component.component_classes).to include("bg-white")
    end

    it "excludes nil values" do
      component = described_class.new(
        padding: nil,
        shadow: nil,
        border: false
      )

      classes = component.component_classes
      expect(classes).not_to include("nil")
    end
  end

  describe "#html_attributes" do
    it "merges HTML options with classes" do
      component = described_class.new(
        class: "custom",
        id: "test",
        data: { value: "123" }
      )

      attributes = component.html_attributes
      expect(attributes[:class]).to include("custom")
      expect(attributes[:id]).to eq("test")
      expect(attributes[:data]).to eq({ value: "123" })
    end
  end
end
