class AddTablesUsersdefoult < ActiveRecord::Migration[6.1]
  def change
    change_column_default(:users, :first_name, 'User first name')
    change_column_default(:users, :last_name, 'User last name')
  end
end
