class User < ActiveRecord::Base
	has_secure_password
	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy


	validates :username, presence: true, uniqueness: true
	validates :password, presence: true, on: :create, length: { minimum: 6 }
end
