class CreateTransactions < ActiveRecord::Migration[8.1]
  def change
    create_table :transactions do |t|
      t.integer :kind
      t.string :description
      t.text :notes
      t.date :occurred_on

      t.monetize :amount, null: false, default: 0

      t.references :user, null: false, foreign_key: true
      t.references :account, { null: false, foreign_key: true }
      t.references :category, null: true, foreign_key: true
      t.timestamps
    end
  end
end
