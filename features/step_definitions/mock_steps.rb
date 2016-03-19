Given(/^a mock with json$/) do |json|
  @response = MockenizeService.createMock(json)
end

When(/^delete a mock with json$/) do |json|
  @response = MockenizeService.deleteMock(json)
end

When(/^update an mock with json$/) do |json|
  @response = MockenizeService.updateMock(json)
end
