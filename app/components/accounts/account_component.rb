# frozen_string_literal: true

module Accounts
  class AccountComponent < ViewComponent::Base
    def initialize(account:)
      @account = account
    end

    private

    attr_reader :account
  end
end
