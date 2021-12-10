class CreateFeedBack < ActiveRecord::Migration[6.1]
  def change
    create_table :feed_backs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :text

      t.timestamps
    end
  end
end
