class AddParametrToBadges < ActiveRecord::Migration[6.1]
  def change
    add_column :badges, :parametr, :string, default: ''
  end
end
