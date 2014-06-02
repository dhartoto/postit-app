class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User' 
  has_many :comments, dependent: :destroy
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable
  
  after_validation :create_slug

  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true
  # validates :create_slug, uniqueness: true

  def count_votes
    count_true - count_false
  end

  def count_true
    self.votes.where(vote: true).size
  end

  def count_false
    self.votes.where(vote: false).size
  end
  
  def create_slug
    self.slug = self.title.gsub(' ', '_').downcase  
  end
   
  def to_param
    self.slug
  end
end