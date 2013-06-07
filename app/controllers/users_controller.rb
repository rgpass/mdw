# This file was generated with the command:
# $ rails generate controller Users new --no-test-framework
# This follows along with the RESTful style architecture


class UsersController < ApplicationController
  # This means that the signed_in_user method has to be
  # called before doing anything else. This method is
  # defined at the bottom. This is saying that the
  # signed_in_user method is only applied before
  # someone does the edit or update actions.
  before_filter :signed_in_user, only: [:edit, :update, :destroy]

  # If it's the correct user, they can edit&update their
  # information, but not other people's.
  before_filter :correct_user,   only: [:edit, :update]

  # The admin_user method is explained below.
  before_filter :admin_user,     only: :destroy

  def show
  	# parmas[:id] comes from the URL in the HTTP request
  	# If someone goes to mdw.com/users/1, the controller
  	# picks up that 1 is the ID. Sometimes you'll have
  	# URL's like mdw.com/?foo=1&bar=cool, this means
  	# params[:foo] would be "1" and
  	# params[:bar] would be "cool"
  	# Note: .find is smart enough to convert "1" to 1
    # To see what params are pulled in via the URL,
    # run $ rake routes
  	@user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    # The params[:user] is pulled from the form_for on the
    # new.html.erb view. It relates to the name of each
    # of the fields (name, password, password_confirmation)
    # and stores them as a hash (of hashes). The line
    # below is the same as:
    # @user = User.new(name: "foo bar", email: "foo@invalid",
    #                  password: "foo", password_confirmation: "bar")
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      # With this defined here, views/layouts/application now
      # will display the message below only after signing in
      # for the first time.
      flash[:success] = "Welcome to My Dysfunctional Workplace!"
      # This is the same as: redirect_to user_url(@user).
      # Not sure why, but it does.
      redirect_to @user
    else
      # Re-render the page but with error messages.
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      # Handle a successful update
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
       # Re-render the page but this time the error
       # messages will show (coded into edit view)
       render 'edit'
    end
  end

  # Since web browsers can't send DELETE requests
  # natively, Rails fakes it via JavaScript. Which
  # means the delete links won't work if the user
  # doesn't have JS enabled. To support non-JS
  # deleting, see the RailsCast on "Destroy Without
  # JavaScript"
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to root_path
  end

  private

    # If the user is not signed in, they should be
    # redirected to the sign in site and notified
    # that they should sign in. Their original
    # requested URL is then stored. This method is
    # defined in SessionsHelper
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    # Redirect to the root path unless the current
    # user is the correct user.
    def correct_user
      @user = User.find(params[:id])
      # The current_user? boolean is defined in
      # app/helpers/sessions_helper.rb
      redirect_to(root_path) unless current_user?(@user)
    end

    # If someone tries to delete something via the
    # Terminal or making a URL for it, they are
    # redirected to root_path unless they're an admin.
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
