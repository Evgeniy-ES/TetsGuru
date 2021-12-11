class AddFeedBacksTextNullConstraint < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:feed_backs, :text, false)
  end
end
