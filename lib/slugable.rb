module Slugable
  extend ActiveSupport::Concern
  
  included do
    if self.class == User
      after_create :create_slug
    else
      before_save :create_slug
    end
    class_attribute :slug_col
  end
  
  def create_slug
    slug = self.send(self.slug_col.to_sym).gsub(' ', '_').downcase
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
  
  module ClassMethods
    def slugable_col(name)
      self.slug_col = name
    end
  end
end