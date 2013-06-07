module SessionsHelper

	# Creates a cookie on that computer when the user is
	# signed in. Using the permanent method, Rails
	# automatically sets the expiration to
	# 20.years.from_now
	# The next line creates current_user, which will be
	# accessible in both controllers and views.
	def sign_in(user)
		cookies.permanent[:remember_token] = user.remember_token
		self.current_user = user
	end

	# Boolean to define if the user is signed in. It
	# says: not if the current user is nil. By looking
	# at the current_user method below, it's pretty
	# much saying, is the current user defined already
	# and/or is the remember_token there? If so, yes
	# they are signed in. Note: The remember_token is
	# deleted when the user is signed out.
	def signed_in?
		!current_user.nil?
	end

	def current_user=(user)
		@current_user = user
	end

	# Finds the current user by their remember token
	# only if @current_user is not already defined.
	# This helps with scaling because the database
	# is only called once per page, then it is stored
	# as @current_user, so if a site references 2+
	# pieces of info from the user, such as their
	# name and how old their profile is, the database
	# is only called to once.
	def current_user
		# The format of ||= is unique to Ruby and helps with
		# trimming down code. In other languages:
		# x = x + 1 can be trimmed to x += 1
		# Similarly, x ||= y is the same as x = x || y
		# if x is nil or false, then x ||= y would
		# return y
		@current_user ||= User.find_by_remember_token(cookies[:remember_token])
	end

	def current_user?(user)
		user == current_user
	end

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

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end

	# Method 1 of 2 for Friendly Forwarding
	# Utilized in the UsersController in create action.
	# Also used in SessionsController in create action.
	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	# Method 2 of 2 for Friendly Forwarding
	# The session facility is provided by rails.
	# Can think of it as an instance cookies variable
	# that deletes upon exiting the browser.
	# We use request object to get the url of the page.
	# Utilized in the signed_in_user method in the
	# UsersController
	def store_location
		session[:return_to] = request.url
	end
end
