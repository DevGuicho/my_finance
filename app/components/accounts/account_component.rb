# frozen_string_literal: true

module Accounts
  class AccountComponent < ViewComponent::Base
    def initialize(account:)
      @account = account
    end

    private

    attr_reader :account

    def transactions_this_month
      @transaction_this_month ||= account.transactions.where(occurred_on: Time.current.beginning_of_month..).count
    end

    def balance_color
      account.current_balance.positive? ? "text-green-500" : "text-red-500"
    end
  end
end
