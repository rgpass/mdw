# This was created to eliminate the chance of two users
# being created when the user double-clicks "Submit"
# Generated with the command:
# $ rails generate migration add_index_to_users_name

class AddIndexToUsersName < ActiveRecord::Migration
  def change
  	# This adds an index in the users table for the
  	# name column, then forces that they are unique
  	add_index :users, :name, unique: true
  end
end
