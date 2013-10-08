# Copyright 2011-2013 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.

source 'https://rubygems.org'

gem 'rails', '3.2.14'

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'squeel'

gem 'attribeautiful', '~> 0.0.6'

gem 'openstax_connect', '~> 0.0.3'
gem 'openstax_utilities', '~> 1.0.1'

gem 'lev', "~> 2.0.2"
gem 'fine_print', "~> 0.1.1"

group :development, :test do
  gem 'sqlite3', '~> 1.3.6'
  gem 'thin'
  gem 'rails-erd'
  gem 'faker'

  gem 'debugger', '~> 1.5.0'
  gem 'quiet_assets'
  gem 'timecop'

  gem 'rspec-rails'
  gem 'capybara', '<2.1.0'  ## see: https://github.com/thoughtbot/capybara-webkit/issues/507
  gem 'capybara-screenshot'
  gem 'capybara-webkit'
  gem 'database_cleaner'
end

group :production do
  gem 'mysql2', '~> 0.3.11'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',     '~> 3.2.3'
  gem 'coffee-rails',   '~> 3.2.1'
  gem 'sass-rails',     '~> 3.2.3'
  gem 'bootstrap-sass', '~> 2.3.1.0'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end
