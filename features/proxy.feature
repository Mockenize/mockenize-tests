# encode: utf-8
Feature: Test proxy features

Scenario: Create a proxy
  Given a proxy with json
  """
  {
    "name" : "my_favorite_proxy",
    "path" : "/proxy",
    "url" : "http://maps.googleapis.com/maps/api/geocode/json?address=Brazil"
  }
  """
  Then response status should be equal 201

  When invoke a "GET" in url "/proxy"
  Then response status should be equal 200
  And response body most contain "Brazil"

Scenario: Update a proxy

  Given a proxy with json
  """
  {
    "name" : "my_favorite_proxy",
    "path" : "/proxy",
    "url" : "http://maps.googleapis.com/maps/api/geocode/json?address=Brazil"
  }
  """
  Then response status should be equal 201

  When invoke a "GET" in url "/proxy"
  Then response status should be equal 200
  And response body most contain "Brazil"

  When update a proxy with json
  """
  {
    "name" : "my_favorite_proxy",
    "path" : "/proxy",
    "url" : "http://maps.googleapis.com/maps/api/geocode/json?address=SBO"
  }
  """
  Then response status should be equal 201

  When invoke a "GET" in url "/proxy"
  Then response status should be equal 200
  And response body most contain "SBO"

Scenario: Delete a proxy

  Given a proxy with json
  """
  {
    "name" : "my_favorite_proxy",
    "path" : "/proxy",
    "url" : "http://maps.googleapis.com/maps/api/geocode/json?address=Brazil"
  }
  """
  Then response status should be equal 201

  When invoke a "GET" in url "/proxy"
  Then response status should be equal 200
  And response body most contain "Brazil"

  When delete a proxy with json
  """
  {
    "name" : "my_favorite_proxy",
    "path" : "/proxy"
  }
  """
  Then response status should be equal 200

  When invoke a "GET" in url "/proxy"
  Then response status should be equal 404

Scenario: Delete a all proxies

  When delete all proxies with json
  """
  []
  """
  Then response status should be equal 200

Scenario: Delete multiple proxies

  Given a proxy with json
  """
  {
    "name" : "my_favorite_proxy",
    "path" : "/proxy",
    "url" : "http://maps.googleapis.com/maps/api/geocode/json?address=Brazil"
  }
  """
  Then response status should be equal 201

  Given a proxy with json
  """
  {
    "name" : "my_favorite_proxy2",
    "path" : "/proxy2",
    "url" : "http://maps.googleapis.com/maps/api/geocode/json?address=Brazil"
  }
  """
  Then response status should be equal 201

  When delete all proxies with json
  """
  [{
    "name" : "my_favorite_proxy",
    "path" : "/proxy",
    "url" : "http://maps.googleapis.com/maps/api/geocode/json?address=Brazil"
  }]
  """
  Then response status should be equal 200

  When invoke a "GET" in url "/proxy"
  Then response status should be equal 404

  When invoke a "GET" in url "/proxy2"
  Then response status should be equal 200
