# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: [ :destroy, :edit, :update ]

  def index
    @accounts = current_user.accounts.includes(:transactions)
    authorize @accounts
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

  def edit
    authorize @account
  end

  def update
    authorize @account

    if @account.update(account_params)
      respond_to do |format|
        format.turbo_stream
        format.html do
          flash[:notice] = "Account was successfully updated."
          redirect_to accounts_path
        end
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @account

    @account.destroy
    respond_to do |format|
      format.turbo_stream
      format.html do
        flash[:notice] = "Account was successfully destroyed."
        redirect_to accounts_path
      end
    end
  end

  private

  def account_params
    params.require(:account).permit(:name, :kind, :current_balance, :current_balance_currency)
  end

  def set_account
    @account = Account.find(params[:id])
  end
end
