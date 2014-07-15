class Comment < ActiveRecord::Base
	include Voteable

	belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
	belongs_to :post

	validates_presence_of :creator, :body, :post
end
