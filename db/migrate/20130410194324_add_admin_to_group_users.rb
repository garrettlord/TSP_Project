class AddAdminToGroupUsers < ActiveRecord::Migration
  def change
    add_column :group_users, :admin, :boolean
  end
end
