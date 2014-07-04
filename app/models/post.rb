class Post < ActiveRecord::Base
	belongs_to :creator, class_name: 'User', foreign_key: 'user_id'

  has_many :comments, dependent: :destroy
	has_many :post_categories, dependent: :destroy
	has_many :categories, through: :post_categories

	validates :title , presence: true

	URL_REGEX = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix
	validates :url , presence: true, format: { with: URL_REGEX }

	validates :description, presence: true
end
