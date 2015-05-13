require 'rails_helper'
require_relative './support/login_helper'

RSpec.configure do |config|
  config.include Capybara::DSL

  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
end

