class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  validates :title, presence: true

  before_save :generate_slug

  def total_votes
    up_votes - down_votes
  end

  def generate_slug
    self.slug = self.title.parameterize
  end

  def to_param
    self.slug
  end

  private

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote: false).size
  end

end
