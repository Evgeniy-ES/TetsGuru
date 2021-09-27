class RenameColumns < ActiveRecord::Migration[6.1]
  def up
    rename_column :questions, :tests_id, :test_id
    rename_column :tests, :categories_id, :category_id
  end

  def down
    rename_column :questions, :test_id, :tests_id
    rename_column :tests, :category_id, :categories_id
  end
end
