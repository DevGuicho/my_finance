# frozen_string_literal: true

module Accounts
  class BannerComponent < ViewComponent::Base
    def initialize(accounts:)
      @accounts = accounts
    end

    private

    attr_reader :accounts

    def balance
      @balance ||= Money.new(accounts.sum(:current_balance_cents), "MXN")
    end
  end
end
