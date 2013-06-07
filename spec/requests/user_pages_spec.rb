# This file runs a test-suite on the static pages
# This file was generated with the command:
# $ rails generate integration_test user_pages

require 'spec_helper'

describe "UserPages" do
  subject { page }

  describe "Signup page" do
  	before { visit signup_path }

  	it { should have_selector('h1',    text: 'Sign Up') }
  	it { should have_selector('title', text: full_title('Sign Up')) }

  	let(:submit) { "Create my account" }

  	describe "With invalid information" do
  		it "Should not create a user" do
  			expect { click_button submit }.not_to change(User, :count)
  		end

  		describe "After submission" do
  			before { click_button submit }

  			it { should have_selector('title', text: 'Sign Up') }
  			it { should have_content('error') }
  		end
  	end

  	describe "With valid information" do
  		before do
  			fill_in "Username",				with: "example user"
  			fill_in "Password",				with: "foobar"
  			fill_in "Confirmation",   with: "foobar"
  		end

  		it "Should create a user" do
  			expect { click_button submit }.to change(User, :count).by(1)
  		end

  		describe "After saving the user" do
  			before { click_button submit }
  			let(:user) { User.find_by_name("example user") }

        # Should re-direct to their profile, give a flash
        # alert, and change the header accordingly.
  			it { should have_selector('title', text: user.name) }
  			it { should have_selector('div.alert.alert-success', text: 'Welcome') }
        it { should have_link('Sign Out') }
  		end
  	end
  end

  describe "Profile page" do
  	let(:user) { FactoryGirl.create(:user) }
  	before { visit user_path(user) }

  	it { should have_selector('h1',    text: user.name) }
  	it { should have_selector('title', text: user.name) }
  end

  describe "Edit profile" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "Page" do
      it { should have_selector('h1',    text: "Update Your Profile") }
      it { should have_selector('title', text: "Edit User") }
    end

    describe "With invalid information" do
      before { click_button "Save Changes" }

      it { should have_content('error') }
    end

    describe "With valid information" do
      let(:new_name) { "New Name" }
      before do
        fill_in "Username",     with: new_name
        fill_in "Password",     with: user.password
        fill_in "Confirmation", with: user.password
        click_button "Save Changes"
      end

      it { should have_selector('title', text: new_name.downcase) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign Out', href: signout_path) }
      specify { user.reload.name.should == new_name.downcase }
    end
  end
end
