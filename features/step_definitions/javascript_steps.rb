Given(/^a JavaScript code with name "([^"]*)" and source code$/) do |javascriptName, sourceCode|
  @response = MockenizeService.createJavascript(javascriptName, sourceCode);
  @javascriptName = javascriptName
end

When(/^update a JavaScript code with name "([^"]*)" and source code$/) do |javascriptName, sourceCode|
  @response = MockenizeService.updateJavascript(javascriptName, sourceCode);
  @javascriptName = javascriptName
end
