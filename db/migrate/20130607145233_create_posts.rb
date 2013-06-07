# Generated when generating the Post model
# the add_index uses two keys, which means Active
# Record uses both keys at the same time.
# Note: :created_at was automatically created
# by t.timestamps. So was :updated_at

class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    add_index :posts, [:user_id, :created_at]
  end
end
