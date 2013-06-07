# Generated with:
# rails generate migration add_admin_to_users admin:boolean
# This file changes our data model so that it is
# defined 

class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, default: false
  end
end
