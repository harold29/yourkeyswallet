class Wallet < ApplicationRecord
    before_create :add_currency_data

    belongs_to :user
    belongs_to :currency

    has_encrypted :pubkey
    has_encrypted :pkey

    validates :address, presence: true
    validates :pubkey, presence: true
    validates :pkey, presence: true
    

    private

    def add_currency_data
        self.currency_name = self.currency.name
        self.symbol = self.currency.symbol
    end

    def self.find_all_by_user(user_id)
        where(user_id: user_id).all
    end
end
