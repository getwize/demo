class Student < ApplicationRecord
	validates :first_name, :last_name, :email, :phone_number, presence: true

	belongs_to :user
	belongs_to :splan
end
