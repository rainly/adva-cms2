ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../host_app', __FILE__)

HostApp.new(File.expand_path('../../..', __FILE__), :template => File.expand_path('../host_app_template.rb', __FILE__)) do
 run 'rake adva:cms:install'
end

require 'cucumber/rails/world'
require 'cucumber/rails/active_record'

require 'webrat'
require 'webrat/core/matchers'

require 'test/unit/assertions'
require 'action_dispatch/testing/assertions'

Webrat.configure do |config|
  config.mode = :rails
  config.open_error_files = false
end

ActionController::Base.allow_rescue = false
Cucumber::Rails::World.use_transactional_fixtures = true

# class Cucumber::Rails::World
#   include Rack::Test::Methods
#   include Cucumber::Rails::World::Adapter
#   include Webrat::Methods
#   include Webrat::Matchers
#   include ActionDispatch::Assertions
# end

Before do
  @current_site = Adva::Site.create!(:name => 'adva-cms', :host => 'adva-cms.com', :title => "adva-cms")
end

Rails.backtrace_cleaner.remove_silencers!

# # How to clean your database when transactions are turned off. See
# # http://github.com/bmabey/database_cleaner for more info.
# if defined?(ActiveRecord::Base)
#   begin
#     require 'database_cleaner'
#     DatabaseCleaner.strategy = :truncation
#   rescue LoadError => ignore_if_database_cleaner_not_present
#   end
# end
