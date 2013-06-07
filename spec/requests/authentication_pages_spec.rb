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
      # The sign_in method is defined in spec/support/utilities.rb
  		before { sign_in user }
  		# After clicking Sign In, it should render the user's
  		# profile page, as described below.
  		it { should have_selector('title', text: user.name) }
  		it { should have_link('View Profile', href: user_path(user)) }
      it { should have_link('Edit Profile', href: edit_user_path(user)) }
  		it { should have_link('Sign Out', href: signout_path) }
  		it { should_not have_link('Sign In', href: signin_path) }

      describe "Followed by signout" do
        before { click_link "Sign Out" }
        it { should have_link("Sign In") }
      end
  	end
  end

  describe "Authorization" do

    describe "For non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      # Test for Friendly Forwarding, aka if you go to a link
      # that requires login, once you login you are forwarded
      # to that page, rather than the default which is your
      # profile page.
      # This is handled by the SessionsHelper
      describe "When attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Username", with: user.name
          fill_in "Password", with: user.password
          click_button "Sign In"  
        end

        describe "After signing in" do

          it "Should render the desired protected page" do
            page.should have_selector('title', text: 'Edit User')
          end
        end
      end

      describe "In the users controller" do

        describe "Visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title', text: 'Sign In') }
        end

        describe "Submitting to the update action" do
          # The put command here submits a PUT request directly
          # to /users/1 which gets routed to the update action
          # of the Users controller. This is necessary because
          # there's no way for a browser to visit the update
          # action directly. 
          before { put user_path(user) }
          # Instead of testing for the page object, we use
          # response which tests for the server response itself
          specify { response.should redirect_to(signin_path) }
        end
      end
    end

    describe "As wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      # Note: FactoryGirl can take an option as seen here.
      let(:wrong_user) { FactoryGirl.create(:user, name: "wrong") }
      before { sign_in user }

      describe "Visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_selector('title', text: full_title('Edit User')) }
      end

      describe "Submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path) }
      end
    end
  end
end
