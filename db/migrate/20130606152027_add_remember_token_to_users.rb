# Generated via:
# $ rails generate migration add_remember_token_to_users
# This was generated so that the user will have a special
# remember token that's associated with a permanent cookie

class AddRememberTokenToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :remember_token, :string
  	add_index  :users, :remember_token 
  end
end
