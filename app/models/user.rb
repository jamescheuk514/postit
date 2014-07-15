class User < ActiveRecord::Base
	include Sluggable

	has_secure_password
	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :votes

	validates :username, uniqueness: true
	validates :password, on: :create, length: { minimum: 6 }
	validates_presence_of :username, :password_digest

	sluggable_column :username

end
