class WalletSerializer < ApplicationSerializer
  attributes :currency_name, 
             :symbol,
             :amount,
             :address,
             :pubkey,
             :pkey,
             :available

  def amount
    object.amount
  end

  def pkey
    object.pkey[0, 5]
  end
end