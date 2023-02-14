class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets, id: :uuid do |t|
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid
      t.belongs_to :currency, null: false, foreign_key: true, type: :uuid
      t.boolean :available, default: true
      t.boolean :deleted, default: false
      t.decimal :amount
      t.string :address, presence: true
      t.string :currency_name, presence: true
      t.string :symbol

      t.timestamps
    end
  end
end
