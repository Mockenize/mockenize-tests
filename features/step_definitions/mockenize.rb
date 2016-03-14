Given(/^a mock with json$/) do |json|
  @response = MockenizeService.createMock(json)
  expect(@response.code).to eq(201)
end

When(/^invoke a "([^"]*)" in url "([^"]*)"$/) do |method, url|
  @response = MockenizeService.load(method, url, "")
end

Then(/^response status should be (\d+)$/) do |status|
  expect(@response.code).to eq(status.to_i)
end

Then(/^response body should be "([^"]*)"$/) do |body|
  expect(body).to eq(@response.body)
end

Then(/^response header should be contains a key "([^"]*)" and value "([^"]*)"$/) do |header_key, header_value|
  expect(@response.headers[header_key]).to start_with(header_value)
end

When(/^delete a mock with json$/) do |json|
  @response = MockenizeService.deleteMock(body)
end
