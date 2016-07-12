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

Given(/^a mock clicking the create button$/) do
  visit "_mockenize/admin/index.html#/mocks"
  click_link "Create"
end

And(/^path "([^"]*)"$/) do |path|
  fill_in "formgroup$1", :with => path
end

And(/^method "([^"]*)"$/) do |method|
  select method, :from => "formgroup$2"
end

And(/^status "([^"]*)"$/) do |status|
  select status, :from => "formgroup$3"
end

And(/^body "([^"]*)"$/) do |body|
  fill_in "formgroup$5", :with => body
end

When(/^I save this mock$/) do
  click_button "Save"
end

Then(/^screen should be changed to mocks$/) do
  expect(current_url).to include("index.html#/mocks")
end

And(/^my mock should be contained in the list\.$/) do
  expect(page).to have_content("/test")
end

Given(/^a mock$/) do
  steps %Q{
    Given a mock clicking the create button
    And path "/test"
    And method "POST"
    And status "202"
    And body "{}"
    When I save this mock
  }
end

When(/^I click in delete button$/) do
  find(".btn-xs").click
end

When(/^I choice yes option$/) do
  accept_alert "Are you sure?"
end

Then(/^my mock should not be contained in the list\.$/) do
  expect(page).to have_no_content("/test")
end

Given(/^that there is no test$/) do
  visit "_mockenize/admin/index.html#/mocks"
  find(".btn.btn-danger").click
  accept_alert "Are you sure?"
end
