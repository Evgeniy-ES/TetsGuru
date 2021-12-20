class CreateBadges < ActiveRecord::Migration[6.1]
  def change
    create_table :badges do |t|
      t.string :name
      t.string :url_badge
      t.references :rule, foreign_key: true

      t.timestamps
    end
  end
end
