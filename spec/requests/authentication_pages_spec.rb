require 'spec_helper'

describe "AuthenticationPages" do
  
  subject { page }

  describe "Signin page" do
  	before { visit signin_path }

  	it { should have_selector('h1',    text: 'Sign In') }
  	it { should have_selector('title', text: 'Sign In') }

  	describe "With invalid information" do
  		before { click_button "Sign In" }

  		it { should have_selector('title', text: 'Sign In') }
  		it { should have_selector('div.alert.alert-error', text: 'Invalid') }

  		describe "After visiting another page" do
  			before { click_link "Home" }
  			it { should_not have_selector('div.alert.alert-error') }
  		end
  	end

  	describe "With valid information" do
  		let(:user) { FactoryGirl.create(:user) }
  		before do
  			fill_in "Username", with: user.name.upcase
  			fill_in "Password", with: user.password
  			click_button "Sign In"
  		end
  		# After clicking Sign In, it should render the user's
  		# profile page, as described below.
  		it { should have_selector('title', text: user.name) }
  		it { should have_link('Profile', href: user_path(user)) }
  		it { should have_link('Sign Out', href: signout_path) }
  		it { should_not have_link('Sign In', href: signin_path) }

      describe "Followed by signout" do
        before { click_link "Sign Out" }
        it { should have_link("Sign In") }
      end
  	end
  end
end
