class AddUserRankToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :user_rank, :string
    add_column :admin_users, :company_name, :string
    add_column :admin_users, :phone_number, :string
    add_column :admin_users, :about_me, :text
    add_column :admin_users, :address, :string
  end
end
