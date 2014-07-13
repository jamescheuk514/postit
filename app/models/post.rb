class Post < ActiveRecord::Base
	include VotesHelper

	belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :comments, dependent: :destroy
	has_many :post_categories, dependent: :destroy
	has_many :categories, -> { uniq },through: :post_categories
	has_many :votes, as: :voteable

	URL_REGEX = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix
	validates :url , uniqueness: true, format: { with: URL_REGEX }
	validates_presence_of :creator, :title, :url, :description, :slug

	before_validation :generate_slug


	def generate_slug
		self.slug = self.title.gsub( ' ', '-' ).downcase
	end

	def to_param
		self.slug
	end
end
