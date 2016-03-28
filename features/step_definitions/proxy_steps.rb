Given(/^a proxy with json$/) do |json|
  @response = MockenizeService.post "/_mockenize/proxies", json
end

When(/^update a proxy with json$/) do |json|
  @response = MockenizeService.put "/_mockenize/proxies", json
end

When(/^delete a proxy with json$/) do |json|
  @response = MockenizeService.delete "/_mockenize/proxies", json
end

When(/^delete all proxies with json$/) do |json|
  @response = MockenizeService.delete "/_mockenize/proxies/all", json
end
