require "httparty"
require "pry"
require "rspec"
require "capybara/cucumber"

$url = "http://localhost:8080"

Capybara.configure do |config|
  config.default_driver = :selenium
  config.app_host = $url
end
