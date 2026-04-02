# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :authenticate_user!

  def index
    @accounts = current_user.accounts

    @balance = current_user.accounts.sum(:initial_balance_cents)
    @balance = Money.new(@balance, "MXN")
  end

  def new
    @account = Account.new
  end

  def create
    @account = current_user.accounts.build(account_params)

    if @account.save
      respond_to do |format|
        format.turbo_stream
        format.html do
          flash[:notice] = "Account was successfully created."
          redirect_to accounts_path
        end
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def account_params
    params.require(:account).permit(:name, :kind, :initial_balance, :initial_balance_currency)
  end
end
