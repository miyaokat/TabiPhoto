class AddFlagsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_deleted, :boolean
    add_column :users, :admin_flag, :boolean
  end
end
