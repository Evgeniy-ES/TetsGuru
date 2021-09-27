class Test < ApplicationRecord
  def self.by_category_name(category)
    join('INNER JOIN categories on tests.categories_id = categories.id' ).
      where( categories: { title: category } ).order(id: :desc).pluck('tests.title')
  end

end
