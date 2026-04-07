# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @total_balance = current_user.accounts.sum(:current_balance_cents)
    @total_balance = Money.new(@total_balance, "MXN")

    @total_income = current_user.transactions.income.sum(:amount_cents)
    @total_income = Money.new(@total_income, "MXN")

    @total_expenses = current_user.transactions.expense.sum(:amount_cents)
    @total_expenses = Money.new(@total_expenses, "MXN")

    @net_income = @total_income - @total_expenses
  end
end
