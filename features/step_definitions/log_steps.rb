When(/^get a log with these filters$/) do |json|
  @response = MockenizeService.post "/_mockenize/logs/find", json
end

When(/^delete all logs$/) do
  @response = MockenizeService.delete "/_mockenize/logs/all", nil
end
