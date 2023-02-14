class User < ApplicationRecord
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  def set_default_role
    self.role ||= :user
  end

  devise :database_authenticatable, 
         :registerable,
         :recoverable, 
         :rememberable, 
         :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist

  has_many :wallets
  has_many :transactions
  has_one :profile
end
