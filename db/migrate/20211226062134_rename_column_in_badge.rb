class RenameColumnInBadge < ActiveRecord::Migration[6.1]
  def change
    rename_column :badges, :name, :title
  end
end
