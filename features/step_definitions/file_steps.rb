Given(/^a file with json$/) do |json|
  Dir.mkdir '/tmp/mockenize' unless Dir.exists? '/tmp/mockenize'
  File.open("/tmp/mockenize/upload.json", "w+") do |file|
    file.write(json)
  end
end

When(/^I send the file$/) do
  @response = MockenizeService.uploadFile("/tmp/mockenize/upload.json");
end
