require 'spec_helper'

describe Post do
  
  let(:user) { FactoryGirl.create(:user) }
  # Build posts through the user, not as a stand-alone
  # object. So wouldn't user @posts = Posts.new(blahblah)
  # instead use user.posts.new(blah) so it's automatically
  # associated with user
  before { @post = user.posts.new(content: "Lorem ipsum") }

  subject { @post }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "When user_id is not present" do
  	before { @post.user_id = nil }
  	it { should_not be_valid }
  end

  # Building posts through the association of the user
  # doesn't fix the security issue that someone could
  # make a post and change the user_id. This tests checks
  # that this is not possible. This test is saying
  # that new posts shouldn't have a user_id assigned to
  # them be default or even if someone tries to change
  # all posts to theirs.
  describe "Accessible attributes" do
  	it "Should not allow access to user_id" do
  		expect do
  			Post.new(user_id: user.id)
  		end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
  	end
  end

  describe "When user_id is not present" do
  	before { @post.user_id = nil }
  	it { should_not be_valid }
  end

  describe "With blank content" do
  	before { @post.content = " " }
  	it { should_not be_valid }
  end

  # Test to limit the length. Not needed for MVP.
  #describe "With content that is too long" do
  #	before { @post.content = "a" * 141 }
  #	it { should_not be_valid }
  #end
end
