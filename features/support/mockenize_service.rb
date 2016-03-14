class MockenizeService
  def self.post (url, body)
    HTTParty.post($url + url, :body => body, :headers => {"Content-Type" => "application/json"})
  end

  def self.createMock (body)
    HTTParty.post($url + "/_mocks", :body => body, :headers => {"Content-Type" => "application/json"})
  end
end
