class MockenizeService
  def self.post (url, body)
    HTTParty.post($url + url, :body => body, :headers => {"Content-Type" => "application/json"})
  end

  def self.get (url, body)
    HTTParty.get($url + url, :body => body, :headers => {"Content-Type" => "application/json"})
  end

  def self.put (url, body)
    HTTParty.put($url + url, :body => body, :headers => {"Content-Type" => "application/json"})
  end

  def self.delete (url, body)
    HTTParty.delete($url + url, :body => body, :headers => {"Content-Type" => "application/json"})
  end

  def self.load (method, url, body)
    if method == 'POST'
      post(url, body)
    elsif method == 'GET'
      get(url, body)
    elsif method == 'PUT'
      put(url, body)
    elsif method == 'DELETE'
      delete(url, body)
    end
  end

  def self.createMock (body)
    HTTParty.post($url + "/_mockenize/mocks", :body => body, :headers => {"Content-Type" => "application/json"})
  end

  def self.deleteMock (body)
    HTTParty.delete($url + "/_mockenize/mocks", :body => body, :headers => {"Content-Type" => "application/json"})
  end

  def self.deleteAllMocks (body)
    HTTParty.delete($url + "/_mockenize/mocks/all", :body => body, :headers => {"Content-Type" => "application/json"})
  end

  def self.updateMock (body)
    HTTParty.put($url + "/_mockenize/mocks", :body => body, :headers => {"Content-Type" => "application/json"})
  end

  def self.createJavascript(scriptName, body)
    HTTParty.post($url + "/_mockenize/scripts/" + scriptName, :body => body, :headers => {"Content-Type" => "application/json"})
  end

  def self.deleteJavascript(scriptName, body)
    HTTParty.delete($url + "/_mockenize/scripts/" + scriptName, :body => body, :headers => {"Content-Type" => "application/json"})
  end

  def self.updateJavascript(scriptName, body)
    HTTParty.put($url + "/_mockenize/scripts/" + scriptName, :body => body, :headers => {"Content-Type" => "application/json"})
  end

  def self.createProxy(body)
    HTTParty.post($url + "/_mockenize/proxies", :body => body, :headers => {"Content-Type" => "application/json"})
  end

  def self.updateProxy(body)
    HTTParty.put($url + "/_mockenize/proxies", :body => body, :headers => {"Content-Type" => "application/json"})
  end
end
