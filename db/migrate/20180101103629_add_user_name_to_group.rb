class AddUserNameToGroup < ActiveRecord::Migration[5.1]
  def change
    add_column :groups, :user_name, :string
  end
end
