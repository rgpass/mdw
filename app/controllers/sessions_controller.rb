# This file was generated with:
# $ rails generate controller Sessions --no-test-framework
# A Session means a connection between two computers. Our
# session will be "forever" unless the user signs out.
# Note: Users are stored in the database, however Sessions
# are stored as cookies.

# The three REST commands, new, create, and destroy, are
# the only ones available as defined in the routes.

class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by_name(params[:session][:name].downcase)
		# The user.authenticate command, when valid, returns the
		# user, however it's important to know that other than
		# nil and false itself, everything else is true in boolean
		# context. 
		if user && user.authenticate(params[:session][:password])
			# Sign the user in and redirect to the user's show page.
			sign_in user
			redirect_to user
		else
			# Create an error message and re-render the signin form.
			flash.now[:error] = 'Invalid username/password combination'
			render 'new'
		end
		
	end

	def destroy
		# sign_out is defined in app/helpers/sessions_helper
		sign_out
		redirect_to root_url
	end
end
