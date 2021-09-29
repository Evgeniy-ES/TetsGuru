class Test < ApplicationRecord
  has_many :questions
  has_many :tests_users
  has_many :users, through: :tests_users
  belongs_to :category
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  
  def self.by_category_name(category)
    join('INNER JOIN categories on tests.categories_id = categories.id' ).
      where( categories: { title: category } ).order(id: :desc).pluck('tests.title')
  end

end
