# This file was generated with the command:
# $ rails generate controller Users new --no-test-framework
# This follows along with the RESTful style architecture


class UsersController < ApplicationController
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
      # With this defined here, views/layouts/application now
      # will display the message below only after signing in
      # for the first time.
      flash[:success] = "Welcome to My Dysfunctional Workplace!"
      # This is the same as: redirect_to user_url(@user).
      # Not sure why, but it does.
      redirect_to @user
    else
      render 'new'
    end
  end
end
