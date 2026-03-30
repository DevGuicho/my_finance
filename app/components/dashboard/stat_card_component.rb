# frozen_string_literal: true

class Dashboard::StatCardComponent < ViewComponent::Base
  VARIANTS = {
    neutral:  { amount: "text-foreground",  icon: "text-body" },
    positive: { amount: "text-green-500",   icon: "text-green-500" },
    negative: { amount: "text-red-500",     icon: "text-red-500" }
  }.freeze

  def initialize(title:, subtitle:, amount:, variant: :neutral)
    @title    = title
    @subtitle = subtitle
    @amount   = amount
    @variant  = VARIANTS.fetch(variant, VARIANTS[:neutral])
  end

  def amount_classes  = @variant[:amount]
  def icon_classes    = @variant[:icon]
end
