# Created with:
# $ rails generate model Post content:string user_id:integer
# By default, the :user_id value was in attr_accessible
# however we do not want that variable to be able to
# be edited, so we remove it from the list.

class Post < ActiveRecord::Base
  attr_accessible :content, :title

  # Associations are done with belongs_to and has_many
  # this is saying that each post belongs_to a user.
  belongs_to :user

  # Could add length: { maximum: 140 } to the end of
  # content to limit to 140 characters.
  validates :content, presence: true
  validates :title,   presence: true, length: { maximum: 40 }
  validates :user_id, presence: true

  # This code assigns the default order to be
  # descending. This is a bit of SQL code.
  # To put it in descending order, we use this, however
  # this would not allow for alterations, so it wouldn't
  # be able to display by most popular or least popular
  # but had to change in index to @posts.desc
  #default_scope order: 'posts.created_at DESC'
  scope :desc, order("posts.created_at DESC")

  # Comes from the Reputation System gem
  # This is saying that the vote comes from the user
  # and is aggregated by sum. For more options, check out
  # the reputation system gem on GitHub
  has_reputation :votes, source: :user, aggregated_by: :sum
end
