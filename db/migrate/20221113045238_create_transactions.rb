class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions, id: :uuid do |t|
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid
      t.belongs_to :transaction_type, null: false, foreign_key: true, type: :uuid
      t.uuid :requester_wallet
      t.uuid :destination_wallet
      t.uuid :destination_user
      t.decimal :transaction_amount
      t.string :operation
      t.string :transaction_state

      t.timestamps
    end
  end
end
