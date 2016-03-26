Given(/^a proxy with json$/) do |json|
  @response = MockenizeService.post "/_mockenize/proxies", json
end

When(/^update a proxy with json$/) do |json|
  @response = MockenizeService.put "/_mockenize/proxies", json
end
