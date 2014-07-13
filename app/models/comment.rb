class Comment < ActiveRecord::Base
	include VotesHelper

	belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
	belongs_to :post
	has_many :votes, as: :voteable

	validates_presence_of :creator, :body, :post
end
