Given(/^a Javascript code with name "([^"]*)" and source code$/) do |javascriptName, sourceCode|
  @response = MockenizeService.createJavascript(javascriptName, sourceCode);
  @javascriptName = javascriptName
end
