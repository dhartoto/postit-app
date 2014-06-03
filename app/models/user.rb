class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes
  
  after_create :create_slug

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
  
  def create_slug
    slug = self.username.gsub(' ', '_').downcase
    slug = slug.strip
    slug = slug.gsub(/\s*[^A-Za-z0-9]\s*/, '_')
    slug = self.slug = slug.gsub(/-+/, '_')
    count = 1
    while !!User.exists?(slug: self.slug) && User.find_by(slug: self.slug) != self
      self.slug = slug + '_' + count.to_s
      count += 1
    end
    self.save
  end
  
  def to_param
    self.slug
  end

end