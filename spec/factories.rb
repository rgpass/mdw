# This file is automatically pulled by RSpec and
# contains all factories to be used in testing.

# Note: By default, creating users is slow because
# bcrypt makes it slow on purpose. You can change it
# so the tests are fast (but less secure) in the file
# config/environments/test.rb (located at bottom)

# See chapter 9 if you need to change this for
# sequencing purposes.
FactoryGirl.define do 
	factory :user do
		name     {(0...8).map{(65+rand(26)).chr}.join.downcase}
		password "foobar"
		password_confirmation "foobar"

		factory :admin do
			admin true
		end
	end

	# By including user in the definition of the factory
	# FactoryGirl already knows that's the associated user.
	factory :post do
		content "Lorem ipsum"
		user
	end
end