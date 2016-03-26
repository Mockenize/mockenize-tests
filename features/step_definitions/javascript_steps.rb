Given(/^a JavaScript code with name "([^"]*)" and source code$/) do |javascriptName, sourceCode|
  @response = MockenizeService.post "/_mockenize/scripts/" + javascriptName, sourceCode
  @javascriptName = javascriptName
end

When(/^update a JavaScript code with name "([^"]*)" and source code$/) do |javascriptName, sourceCode|
  @response = MockenizeService.put "/_mockenize/scripts/" + javascriptName, sourceCode
  @javascriptName = javascriptName
end
