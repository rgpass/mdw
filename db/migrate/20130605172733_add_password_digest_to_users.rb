# This was generated with:
# $ rails generate migration add_password_digest_to_users password_digest:string
# This point of this file is to provide an encrypted
# password for each user.
# Rails automatically constructs a migration to add
# columns to the users table because we ended the
# generation with _to_users

class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string
  end
end
