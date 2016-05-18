require 'rest-client'

class MockenizeService

  def self.post (url, body, content_type={"Content-Type" => "application/json"})
    HTTParty.post($url + url, :body => body, :headers => content_type)
  end

  def self.get (url, body, content_type={"Content-Type" => "application/json"})
    HTTParty.get($url + url, :body => body, :headers => content_type)
  end

  def self.put (url, body, content_type={"Content-Type" => "application/json"})
    HTTParty.put($url + url, :body => body, :headers => content_type)
  end

  def self.delete (url, body, content_type={"Content-Type" => "application/json"})
    HTTParty.delete($url + url, :body => body, :headers => content_type)
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

  def self.uploadFile(file)
     RestClient.post($url + '/_mockenize/file/upload', File.read(file), :content_type => 'application/octet-stream')
  end
end
