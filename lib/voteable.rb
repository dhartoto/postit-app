module Voteable
  extend ActiveSupport::Concern
  
  included do
    has_many :votes, as: :voteable
  end
  
  def count_votes
    count_true - count_false
  end

  def count_true
    self.votes.where(vote: true).size
  end

  def count_false
    self.votes.where(vote: false).size
  end
end