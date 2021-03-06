class Test < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :test_passages, dependent: :destroy
  has_many :users, through: :test_passages
  belongs_to :category
  belongs_to :author, class_name: 'User', foreign_key: :author_id

  scope :find_category_name, -> (category)  { joins(:category).where(categories: { title: category })}

  scope :simple_level,  -> { where(level: 0..1) }
  scope :average_level, -> { where(level: 2..4) }
  scope :high_level,    -> { where(level: 5..Float::INFINITY)}

  def self.by_category_name(category)
    find_category_name(category).order(id: :desc)
  end

  validates :title, presence: true, uniqueness: { scope: :level}
  validates :level, numericality: { greater_than_or_equal_to: 1}

end
