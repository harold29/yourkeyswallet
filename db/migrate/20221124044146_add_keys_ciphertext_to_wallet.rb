class AddKeysCiphertextToWallet < ActiveRecord::Migration[7.0]
  def change
    add_column :wallets, :pubkey_ciphertext, :text
    add_column :wallets, :pkey_ciphertext, :text
  end
end
