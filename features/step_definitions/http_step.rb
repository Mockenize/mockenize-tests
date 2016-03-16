Then(/^response status should be (\d+)$/) do |status|
  expect(@response.code).to eq(status.to_i)
end

Then(/^response body should be "([^"]*)"$/) do |body|
  expect(body).to eq(@response.body)
end

Then(/^response header should be contains a key "([^"]*)" and value "([^"]*)"$/) do |header_key, header_value|
  expect(@response.headers[header_key]).to start_with(header_value)
end

Then(/^response timeout should be (\d+)$/) do |timeout|
  expect(@response_time).to be >= timeout.to_f
end

Then(/^response timeout should be between (\d+) and (\d+)$/) do |minTimeout, maxTimeout|
  expect(@response_time).to be_between(minTimeout.to_f, maxTimeout.to_f).exclusive
end

When(/^invoke a "([^"]*)" in url "([^"]*)"$/) do |method, url|
  start = Time.now
  @response = MockenizeService.load(method, url, "")
  @response_time = Time.now - start
end
