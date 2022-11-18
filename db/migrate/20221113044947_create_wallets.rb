class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets, id: :uuid do |t|
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid
      t.belongs_to :currency, null: false, foreign_key: true, type: :uuid
      t.string :wallet_key
      t.boolean :available
      t.decimal :amount
      t.string :currency_name
      t.string :symbol

      t.timestamps
    end
  end
end
