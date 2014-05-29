class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 8}

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