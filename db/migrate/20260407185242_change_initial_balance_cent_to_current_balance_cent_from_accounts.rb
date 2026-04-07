class ChangeInitialBalanceCentToCurrentBalanceCentFromAccounts < ActiveRecord::Migration[8.1]
  def change
    rename_column :accounts, :initial_balance_cents, :current_balance_cents
    rename_column :accounts, :initial_balance_currency, :current_balance_currency
  end
end
