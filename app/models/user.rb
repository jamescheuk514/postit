class User < ActiveRecord::Base

	has_secure_password
	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :votes

	validates :username, presence: true, uniqueness: true
	validates :password, presence: true, on: :create, length: { minimum: 6 }
	validates_presence_of :username, :password_digest, :slug

	before_validation :generate_slug

	def generate_slug
		self.slug = self.username.gsub(' ', '-').downcase
	end

	def to_param
		self.slug
	end
end
