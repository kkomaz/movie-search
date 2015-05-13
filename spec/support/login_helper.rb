module FeatureHelpers
  def login(user)
    visit '/'
    fill_in 'email', :with => user.email
    fill_in 'password', :with => user.password
    click_on "Login"
  end
end

RSpec.configure do |config|
  config.include FeatureHelpers, type: :feature
end