require 'rails_helper'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist
Capybara.ignore_hidden_elements = false

RSpec.configure do |config|
  config.before(:each, js: true) do
    Capybara.page.driver.resize("1300","1240")
    Capybara.page.driver.clear_cookies
  end

  config.after(:each, js: true) do
    Capybara.page.driver.reset!
  end
  config.include Capybara::DSL
end
