class Currency < ApplicationRecord
  before_validation :set_currency_kind

  validates :name, presence: true
  validates :code, presence: true
  validates :currency_kind, presence: true

  def set_currency_kind
    self.currency_kind = self.name&.parameterize&.underscore
  end
end
