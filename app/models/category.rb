class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories
  
  before_save :create_slug
  
  validates :name, presence: true
  
  def create_slug
    slug = self.name.gsub(' ','_').downcase
    slug = slug.strip
    slug = slug.gsub!(/\s*[^A-Za-z0-9]\s*/, '_')
    slug = self.slug = slug.gsub!(/-+/,'_')
    count = 1
    while !!Category.exists?(slug: self.slug) && Category.find_by(slug: self.slug)!= self
      self.slug = slug + '_'+ count.to_s
      count += 1
    end
    self.slug
  end
  
  def to_param
    self.slug
  end
end