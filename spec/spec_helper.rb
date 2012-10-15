# coding: utf-8
require 'rubygems'
require 'master_cache'

# connection
ActiveRecord::Base.configurations = {'test' => {:adapter => 'sqlite3', :database => ':memory:'}}
ActiveRecord::Base.establish_connection('test')

require 'database_cleaner'
RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
  end
  config.before(:each){ DatabaseCleaner.start }
  config.after(:each){ DatabaseCleaner.clean }
end
