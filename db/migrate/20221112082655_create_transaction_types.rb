class CreateTransactionTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :transaction_types, id: :uuid do |t|
      t.string :transaction_type
      t.string :description

      t.timestamps
    end
  end
end
