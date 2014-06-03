class Post < ActiveRecord::Base
  include Voteable
  
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User' 
  has_many :comments, dependent: :destroy
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true
  
  def create_slug
    slug = self.title.gsub(' ','_').downcase
    slug = slug.strip
    slug = slug.gsub(/\s*[^A-Za-z0-9]\s*/, '_')
    slug = self.slug = slug.gsub(/-+/,'_')
    count = 1
    while !!Post.exists?(slug: self.slug) && Post.find_by(slug: self.slug)!= self
      self.slug = slug + '_'+ count.to_s
      count += 1
    end
    self.slug
  end
   
  def to_param
    self.slug
  end
end