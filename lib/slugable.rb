module Slugable
  extend ActiveSupport::Concern
  
  included do
    if self.class == User
      after_create :create_slug
    else
      before_save :create_slug
    end
  end
  
  def create_slug
    case
      when self.class == Post then slug = self.title.gsub(' ','_').downcase
      when self.class == User then slug = self.username.gsub(' ','_').downcase
      when self.class == Category then slug = self.name.gsub(' ','_').downcase
    end
    slug = slug.strip
    slug = slug.gsub(/\s*[^A-Za-z0-9]\s*/, '_')
    slug = self.slug = slug.gsub(/-+/,'_')
    count = 1
    while !!self.class.exists?(slug: self.slug) && self.class.find_by(slug: self.slug)!= self
      self.slug = slug + '_'+ count.to_s
      count += 1
    end
    self.slug
  end
   
  def to_param
    self.slug
  end
end