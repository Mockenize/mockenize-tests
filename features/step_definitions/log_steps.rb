When(/^get a log with these filters$/) do |json|
  @response = MockenizeService.post "/_mockenize/logs/find", json
end
