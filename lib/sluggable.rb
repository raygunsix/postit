module Sluggable
  extend ActiveSupport::Concern

  included do
    before_create :generate_slug
    class_attribute :slug_column
  end

  def generate_slug
    self.slug = self.send(self.class.slug_column.to_sym).parameterize
    make_unique_slug while slug_exists?
  end

  def to_param
    self.slug
  end

  def make_unique_slug
    if /-[0-9]+$/.match(self.slug)
      slug_parts = self.slug.split('-')
      num = slug_parts[-1].to_i
      if num > 0
        num = num + 1
        slug_parts[-1] = num.to_s
        self.slug = slug_parts.join("-")
      end
    else
      self.slug << "-2"
    end
  end

  def slug_exists?
    slug = self.class.find_by slug: self.slug
    !!slug
  end

  module ClassMethods
    def sluggable_column(col_name)
      self.slug_column = col_name
    end
  end
end