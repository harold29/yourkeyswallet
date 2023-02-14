class Transaction < ApplicationRecord
  belongs_to :user

  def self.find_all_by_user_id(user_id)
    where(user_id: user_id).all
  end
end
