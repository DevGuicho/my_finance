# frozen_string_literal: true

class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @transactions = current_user.transactions
  end

  def new
    @transaction = Transaction.new
  end

  def create
    account = policy_scope(Account).find(transaction_params[:account_id])
    category = policy_scope(Category).find(transaction_params[:category_id])

    @transaction = current_user.transactions.build(transaction_params)
    @transaction.category = category
    @transaction.account = account

    authorize @transaction

    if @transaction.save
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(policy(Transaction).permitted_attributes)
  end
end
