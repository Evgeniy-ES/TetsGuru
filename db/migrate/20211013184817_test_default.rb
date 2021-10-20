class TestDefault < ActiveRecord::Migration[6.1]
  def up
    change_column_default(:tests, :title, 'How are you?')
  end

  def down
    change_column_default(:tests, :title, nil)
  end
end
