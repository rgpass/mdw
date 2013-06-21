# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Note: The above information was automatically generated
# once the Annotate gem was installed. To update this once
# the model changes, run $ bundle exec annotate

# This was created with the command:
# $ rails generate model User name:string
# This also created db/migrate file and a rspec file

class User < ActiveRecord::Base
  # This lists which attributes can be modified by 
  # outside users via requests with web browsers
  # By default, ALL model attributes are accessible, but
  # attr_accessible means that those attributes are
  # automatically accessible to outside users.
  # Note: admin is not on this list because
  # attr_accessible attributes are the only attributes
  # that can be mass assigned. This is for site security.
  # Now a user can't send a put request of
  # /users/17?admin=1 and change their admin rights.
  attr_accessible :name, :password, :password_confirmation

  # This is Rails magic. Explanation can be found in
  # Hartl's guide in section 6.3.4
  # With this, though, you can see that @user's
  # password_digest is encrypted, but you can use
  # user.authenticate("rightpassword") and it will
  # return the user (instead of false)
  has_secure_password

  # Associations are done with the belongs_to and
  # has_many commands in the models. This is saying
  # each user has_many posts associated with them.
  # Check the post model for info on that.
  # The dependent: :destroy ensures that posts
  # are deleted when the user is deleted.
  has_many :posts, dependent: :destroy

  # This makes sure that the user name is saved in all
  # lowercase. This is necessary because not all
  # databases support case-sensitive indices.
  # For example, SQLite3 does, but PosgreSQL does not.
  before_save { name.downcase! }

  # This creates a permanent token to be used as the
  # cookie. See the bottom of the page for more details.
  before_save :create_remember_token

  # Validations are typically done for presence, length
  # format, and uniqueness. For passwords and sometimes
  # emails, there's another validation for confirmation.
  # The first line defines what characters are
  # allowed by using a regular expression. This one
  # says they can letters and spaces only, but cannot
  # start or end with a space.
  VALID_NAME_REGEX = /^[a-zA-Z]+( [a-zA-Z]+)*$/
  validates :name, presence: true, 
  								 length: { maximum: 30},
  # TO-DO -- remove uppercase letters from REGEX
  # as some databases do not allow for case-sensitive
  # indecies. All user names must be lowercase.
  								 format: { with: VALID_NAME_REGEX },
  # Although the uniqueness should be tested in the 
  # model, it also needs to be tested in the database.
  # This will prevent a user from double-clicking on
  # the submit button and accidentally making two
  # users. This is done in the migration:
  # add_index_to_users_name
  								 uniqueness: { case_sensitive: false }
  # Passwords have to exist and be of significant length
  # Removing presence: true for :password eliminates
  # the duplicate errors when signing up, however it puts
  # the errors in an incorrect order. Need to investigate
  # this further.
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  # Keeps track of how how many votes the user has received
  has_reputation :votes, source: {reputation: :votes, of: :posts}, aggregated_by: :sum

  private 

    # Creates a secure token to verify that the user
    # is the right person and eliminates the security
    # threat of session hijacking.
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
