# This file is automatically pulled by RSpec and
# contains all factories to be used in testing.

# Note: By default, creating users is slow because
# bcrypt makes it slow on purpose. You can change it
# so the tests are fast (but less secure) in the file
# config/environments/test.rb (located at bottom)

FactoryGirl.define do 
	factory :user do
		name     "Gerry Pass"
		password "foobar"
		password_confirmation "foobar"
	end
end