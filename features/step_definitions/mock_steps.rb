Given(/^a mock with json$/) do |json|
  @response = MockenizeService.post "/_mockenize/mocks", json
  @mock = JSON.parse(@response.body);
end

When(/^delete a mock with json$/) do |json|
  @response = MockenizeService.delete "/_mockenize/mocks", json
end

When(/^delete a mock using key$/) do  
  @response = MockenizeService.delete "/_mockenize/mocks/" + @mock['key'], nil
end

When(/^delete all mocks with json$/) do |json|
  @response = MockenizeService.delete "/_mockenize/mocks/all", json
end

When(/^update an mock with json$/) do |json|
  @response = MockenizeService.put "/_mockenize/mocks", json
end
