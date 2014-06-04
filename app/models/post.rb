class Post < ActiveRecord::Base
  include Voteable
  include Slugable
  
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User' 
  has_many :comments, dependent: :destroy
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true
  
  slugable_col :title
end