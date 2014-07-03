class Post < ActiveRecord::Base
	belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
 	has_many :comments
	has_many :postcategories
	has_many :categories, :through => :postcategories
end
