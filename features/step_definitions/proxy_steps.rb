Given(/^a proxy with json$/) do |json|
  @response = MockenizeService.createProxy(json)
end

When(/^update a proxy with json$/) do |json|
  @response = MockenizeService.updateProxy(json)
end
