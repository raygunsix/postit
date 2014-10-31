class Post < ActiveRecord::Base
  include Voteable

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, presence: true

  before_save :generate_slug

  def generate_slug
    self.slug = self.title.parameterize
    make_unique_slug while slug_exists?
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
    slug = Post.find_by slug: self.slug
    !!slug
  end

  def to_param
    self.slug
  end

end
