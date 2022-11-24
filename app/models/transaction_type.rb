class TransactionType < ApplicationRecord
  validates :name, presence: true
end
