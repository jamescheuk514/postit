class Post < ActiveRecord::Base
	include Voteable
	include Sluggable
	include PgSearch

	belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :comments, dependent: :destroy
	has_many :post_categories, dependent: :destroy
	has_many :categories, -> { uniq },through: :post_categories

	URL_REGEX = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix
	validates :url , uniqueness: true, format: { with: URL_REGEX }
	validates_presence_of :creator, :title, :url

	sluggable_column :title
	pg_search_scope :search, :associated_against => {
										:creator => :username,
										:categories => :name
								  },:against => {
								    :title => 'A',
								    :description => 'B'
								  }, :using => {
                    :tsearch => {:prefix => true, :dictionary => "english", :any_word => true}
									}
end
