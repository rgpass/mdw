# This was created with the command:
# $ rails generate model User name:string
# This also created app/models/user.rb and a rspec file
# You'll notice that the timestamps are there by default
# Those include created_at and updated_at
# You'll see that the table created is :users (plural)
# Rails linguistic convention is that a model represents
# a single user, whereas a database table consists of
# many users.
# Note: The users controller should be generated first
# then the user model follows
# To view this data, open up a SQLite Database Browser
# and open the file db/development.sqlite3. You'll notice
# that the id column is automatically created

class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name

      t.timestamps
    end
  end
end
