class Category < ActiveRecord::Base

	has_many :post_categories, dependent: :destroy
	has_many :posts, through: :post_categories

	validates :name, uniqueness: true
	validates_presence_of :name, :slug

	before_validation :generate_slug

	def generate_slug
		self.slug = self.name.gsub(' ', '-').downcase
	end

	def to_param
		self.slug
	end
end
