Given(/^a mock with json$/) do |mock|
  MockenizeService.createMock(mock)
end

When(/^invoke a POST in url "([^"]*)"$/) do |url|
  @response = MockenizeService.post(url, "")
end

Then(/^response status should be (\d+)$/) do |status|
  expect(@response.code).to eq(status.to_i)
end

Then(/^response body should be "([^"]*)"$/) do |body|
  expect(body).to eq(@response.body)
end

Then(/^response header should be contains a key "([^"]*)" and value "([^"]*)"$/) do |header_key, header_value|
  expect(@response.headers[header_key]).to eq(header_value)
end
