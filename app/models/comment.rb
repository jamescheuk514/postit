class Comment < ActiveRecord::Base
	include VotesHelper

	belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
	belongs_to :post
	has_many :votes, as: :voteable

	validates :body, presence: true
	validates :post, presence: true
	validates :creator, presence: true

	def voted?(current_user)
		self.votes.where(user_id: current_user.id).blank?
	end
end
