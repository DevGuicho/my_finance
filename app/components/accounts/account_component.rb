# frozen_string_literal: true

module Accounts
  class AccountComponent < ViewComponent::Base
    def initialize(account:)
      @account = account
    end

    private

    attr_reader :account

    def transactions_this_month
      account.transactions.where(occurred_on: Time.current.beginning_of_month..)
    end

    def balance_color
      account.current_balance > 0 ? "text-green-500" : "text-red-500"
    end
  end
end
