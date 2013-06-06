class ApplicationController < ActionController::Base
  protect_from_forgery

  # By default, all helpers are available in views, but
  # not in controllers, so we call in the sessions helper
  # to support signin/out functionality.
  include SessionsHelper

  # Force signout to prevent CSRF atacks
  def handle_unverified_request
  	sign_out
  	super
  end
end
