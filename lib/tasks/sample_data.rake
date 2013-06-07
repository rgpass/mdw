# This uses the Faker gem to create sample users.
# This defines a task db:populate that creates
# example users similar to the first user.
# This is similar to a FactoryGirl factory, however
# this is used outside of tests to visually see
# the affects of having several users/stories.

namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		admin =User.create!(name: "example user",
								 				password: "foobar",
								 				password_confirmation: "foobar")
		admin.toggle!(:admin)
		99.times do |n|
			# Normally could user Faker, however with using name
			# instead of first_name, there was a problem since
			# the names have prefixes including .'s which violates
			# the regex defined by the UserController. Only using
			# first names caused there to be duplicates, last
			# names made it violate 30 character limit. 
			# The code below creates 9 random characters and
			# combines them. Could have a variable length by
			# replacing 8 with rand(29)
		#	name   = Faker::Name.first_name.downcase + " " + Faker::Name.last_name.downcase
			name = (0...8).map{(65+rand(26)).chr}.join.downcase
			password = "password"
			User.create!(name: name,
									 password: password,
									 password_confirmation: password)
		end
		users = User.all(limit: 6)
		50.times do
			content = Faker::Lorem.sentence(5)
			users.each { |user| user.posts.create!(content: content) }
		end
	end
end