# Copyright 2011-2013 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# require 'capybara/rspec'
# require 'capybara-screenshot/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  # see http://devblog.avdi.org/2012/08/31/configuring-database_cleaner-with-rails-rspec-capybara-and-selenium/
  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  # # Test capybara that we always want a javascript-capable driver.
  # # Webkit is a headless, javascript-capable browser.
  # # Selenium drives an actual Firefox browser.
  # Capybara.javascript_driver = :webkit
  # Capybara.default_driver    = :webkit
  # # Capybara.javascript_driver = :selenium
  # # Capybara.default_driver    = :selenium

  # Capybara.default_selector = :css
  
  # # Turn off automatic screencapture when scenario fails
  # Capybara::Screenshot.autosave_on_failure = false

  # # This causes capybara #has_css? and #find selectors to return quickly
  # # in the event of a failure
  # Capybara.default_wait_time = 0.01;

  ###########################################################
  # FORCE ALL THREADS TO SHARE ONE CONNECTION TO THE DATABASE
  ###########################################################
  #
  # Database transactions are determined on a per-connection basis.  Each thread (or
  # process) accessing the database establishes its own connection.
  #
  # There are two components to Capybara scenarios: "scenario steps" and the "browser".
  #
  # When Capybara runs using the :rack_test "browser", everything runs in one thread.
  # This means that the scenario steps and browser share the same database connection
  # and therefore can see each other's uncommitted database transactions. For example,
  # if a scenario step programatically adds data to the database:
  #     create_new_item(:name => "Thingy")
  # then that change is visible to the browser:
  #     visit '/item/1'
  #
  # However, when Capybara runs using any other "broswer" than :rack_test, is launches
  # the browser in a separate thread.  Now the scenario steps and browser have separate
  # database connections and therefore do NOT see each other's uncommitted transactions.
  # In the example above, the browser would get a "page not found" error because item
  # 'Thingy' doesn't exist in its database connection.
  #
  # The following code (plus a snippet in the Spork.for_each block) causes all database
  # users to share the same connection.
  #
  # IMPORTANT NOTE:
  #
  # This will NOT protect against threading issues in the scenarios themselves.  For
  # example, you have the steps:
  #    When I click on then button to create item in database 
  #    Then there should be an item in the database
  # you are introducing a potential race condition.  The second step needs to block on
  # something that tells it that the browser in the first step actually finished its
  # interactions with the database.
  #
  # For details, see:
  #   http://rubydoc.info/github/jnicklas/capybara/master#The_DSL
  #   http://blog.plataformatec.com.br/2011/12/three-tips-to-improve-the-performance-of-your-test-suite/
  #   http://devblog.avdi.org/2012/08/31/configuring-database_cleaner-with-rails-rspec-capybara-and-selenium/
  # class ActiveRecord::Base
  #   mattr_accessor :shared_connection
  #   @@shared_connection = nil
  
  #   def self.connection
  #     @@shared_connection || retrieve_connection
  #   end
  # end

  config.before :suite do
    DatabaseCleaner.clean_with :truncation
  end

  config.before :each do
    DatabaseCleaner.strategy = :truncation
  end

  config.before :each do
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end

  config.before :each do
    email_deliveries_clear
  end
end
