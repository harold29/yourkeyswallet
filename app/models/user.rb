class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :registerable,
         :recoverable, 
         :rememberable, 
         :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist

  has_many :wallets
  has_many :transactions
  has_one :location
  has_one :profile

  end
