# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
  
  before do
  	@user = User.new(name: "Example User", 
  									 password: "foobar", 
  									 password_confirmation: "foobar")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:admin) }
  it { should respond_to(:authenticate) }

  it { should be_valid }
  it { should_not be_admin }

  describe "With admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  describe "When name is not present" do
  	before { @user.name = " " }
  	# If there is a valid? boolean method, in RSpec
  	# there will always be a test of
  	# should be_valid
  	# If there's a awesome? boolean, RSpec will have
  	# a test of: should be_awesome
  	it { should_not be_valid }
  end

  describe "When name is too long" do
  	before { @user.name = "a" * 31 }
  	it { should_not be_valid }
  end

  describe "When name format is invalid" do
  	it "Should be invalid" do
			badnames = ["abc!", "def@", "ghi#", "jkl$",
									"mno%", "pqr^", "stu&", "vwx*",
								  "yz(", "abc)", "def[", "ghi]",
								  "abc1", "abc ", "abc def1", " abc",
								  "1abc"]
  		badnames.each do |invalid_name|
  			@user.name = invalid_name
  			@user.should_not be_valid
  		end 
  	end
  end

  describe "When name format is valid" do
  	it "Should be valid" do
  		goodnames = ["employee", "sad man"]
  		goodnames.each do |valid_name|
  			@user.name = valid_name
  			@user.should be_valid
  		end
  	end
  end

  describe "When name is already taken" do
  	before do
  		user_with_same_name = @user.dup
  		user_with_same_name.name = @user.name.upcase
  		user_with_same_name.save
  	end

  	it { should_not be_valid }
  end

  describe "Name with mixed case" do
  	let (:mixed_case_name) { "FooBar" }

  	it "Should be saved as all lower-case" do
  		@user.name = mixed_case_name
  		@user.save
  		@user.reload.name.should == mixed_case_name.downcase
  	end
  end

  describe "When password is not present" do
  	before { @user.password = @user.password_confirmation = " " }
  	it { should_not be_valid }
  end

  describe "When password doesn't match confirmation" do
  	before { @user.password_confirmation = "mismatch" }
  	it { should_not be_valid }
  end

  describe "When password confirmation is nil" do
  	before { @user.password_confirmation = nil }
  	it { should_not be_valid }
  end

  describe "With a password that's too short" do
  	before { @user.password = @user.password_confirmation = "a" * 5 }
  end

  describe "Return value of authenticate method" do
  	before { @user.save }
  	let(:found_user) { User.find_by_name(@user.name) }

  	describe "With valid password" do
  		# The authenticate method will return the user if it matches
  		# If it does not match, it will return false
  		it { should == found_user.authenticate(@user.password) }
  	end

  	describe "With invalid password" do
  		let (:user_for_invalid_password) { found_user.authenticate("invalid") }

  		it { should_not == user_for_invalid_password }
  		# Specify means the same thing as 'it' but it used when
  		# specify would sound grammatically better than it
  		specify { user_for_invalid_password.should be_false }
  	end
  end

  describe "Remember token" do
    before { @user.save }
    # Similar to it, its applies the subsequent test to 
    # then given attribute rather than to the subject
    # of the test (which is @user in this case)
    its(:remember_token) { should_not be_blank }
  end
end
