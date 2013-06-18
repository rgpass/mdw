# Generated with:
# $ rails generate migration change_content_to_text
# This had to be done because a string by default on PostgreSQL
# is limited to 255 characters. Text however has a much
# larger limit. Now able to submit large stories.
class ChangeContentToText < ActiveRecord::Migration
  def up
  	change_column :posts, :content, :text
  end

  def down
  	change_column :posts, :content, :string
  end
end
