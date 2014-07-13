module VotesHelper

  def total_votes
    up_votes - down_votes
  end

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote: false).size
  end

  def voted?(current_user)
    self.votes.where(user_id: current_user.id).blank?
  end
end
