class AddPossibilityOfPassingToTests < ActiveRecord::Migration[6.1]
  def change
    add_column :tests, :possibility_of_passing, :boolean, default: false
  end
end
