class AddSuccessToTestPassages < ActiveRecord::Migration[6.1]
  def change
    add_column :test_passages, :test_success, :boolean, default: false
  end
end
