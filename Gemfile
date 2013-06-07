source 'https://rubygems.org'

gem 'rails', '3.2.13'
# Bootstrap provides awesome CSS formats and user interface
# elements. These can be found in any of the app/views 
# files where a class is specified
gem 'bootstrap-sass', '2.1'
# bcrypt is a state-of-the-art hash function which
# irreversibly encrypts the password to form the
# password hash. After $ bundle install, run
# gem install bcrypt-ruby
gem 'bcrypt-ruby', '3.0.1'
# Faker allows you to make sample users with
# semi-realistic names (and email addresses). This
# way you don't have a user1 user2 user3 etc. but
# you'll have Dr. James Brown, Jane Smith, etc.
# This can be seen in lib/tasks/sample_data.rake
gem 'faker', '1.0.1'
# Pagination allows for long lists of data aka
# an index of all users or stories to be separated
# onto several pages. Bootstrap's pagination styles
# require the Bootstrap pagination gem.
gem 'will_paginate', '3.0.3'
gem 'bootstrap-will_paginate', '0.0.6'

# These gems are not used when deployed
group :development do
	# SQLite is used on your hard drive, used when looking at
	# localhost:3000 only
	gem 'sqlite3', '1.3.5'
	# RSpec allows you to write your tests for Test
	# Driven Development. After installing, run the command:
	# $ rails generate rspec:install
	gem 'rspec-rails', '2.11.0'
	# Annotate gem gives commented information in the model
	# files to help with organization. Similar to the
	# Data_Model.txt file that is manually updated
	# Note: After $ bundle install, run $ bundle exec annotate
	gem 'annotate', '2.5.0'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
	# Sass is like CSS, but allows for more user-friendly coding
	# If you go to ~/app/assets/stylesheets, you will see some files
	# that end with .css.scss -- these are Sass sheets
  gem 'sass-rails',   '3.2.5'
  # CoffeeScript is a framework for JavaScript, similar to jQuery
  gem 'coffee-rails', '3.2.2'
  gem 'uglifier', '1.2.3'
end

gem 'jquery-rails', '2.0.2'

group :test do
	# Capybara works with RSpec to make the tests easier to code
	# You'll notice how the code in ~/spec/requests looks like English
	# this is because of Capybara
	gem 'capybara', '1.1.2'
	# FactoryGirl allows you to easily create fake data to
	# test out the functionality of your tests. Example: you
	# can use it to create 100 users, who have 100 stories. Then
	# you can make sure pagination is working right.
	# All factories are in spec/factories.rb
	# and are utilized all over spec/
	gem 'factory_girl_rails', '4.1.0'
end

group :production do
	# The pg gem is the database used by Heroku. Short for PosgreSQL
	# which is pronounced Post-greS-Q-L
	gem 'pg', '0.12.2'
end