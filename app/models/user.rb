class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  #highlights the various roles,you can change as needed
  enum role: [:user, :admin, :silver, :gold, :platinum]

  devise :database_authenticatable, :registerable,:omniauthable,
  :recoverable, :rememberable, :trackable, :validatable
  
  belongs_to :plan
  has_many :students, dependent: :destroy
  has_many :splans, dependent: :destroy
  has_many :coupons, dependent: :destroy
end
