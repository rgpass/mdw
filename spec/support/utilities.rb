# This file was manually created to define a method
# to be used in the test-suite
# This can specifically be found in
# spec/requests/static_pages_spec.rb

def full_title(page_title)
  base_title = "My Dysfunctional Workplace"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def sign_in(user)
	visit signin_path
	fill_in "Username", with: user.name.upcase
	fill_in "Password", with: user.password
	click_button "Sign In"
	cookies[:remember_token] = user.remember_token
end