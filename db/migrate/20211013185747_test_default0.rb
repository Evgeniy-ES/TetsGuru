class TestDefault0 < ActiveRecord::Migration[6.1]
  def up
    change_column_default(:tests, :level, 0)
    add_index :tests, %i[title level], unique: true
  end

  def down
    change_column_default(:tests, :level, nil)
  end
end
