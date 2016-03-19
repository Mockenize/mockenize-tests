# encode: utf-8
Feature: Test proxy features

Scenario: Create a proxy
  Given a mock with json
  """
  {
    "path" : "test",
    "method" : "POST",
    "status" : 202,
    "body" : "OK"
  }
  """
  Then response status should be 201

  Given a proxy with json
  """
  {
    "name" : "_proxy",
    "path" : "/proxy",
    "url" : "http://maps.googleapis.com/maps/api/geocode/json?address=Brazil"
  }
  """
  Then response status should be 201

  When invoke a "GET" in url "/proxy"
  Then response status should be 200
  And response body should contains "Brazil"

Scenario: Update a proxy
  GivenScenario Create a proxy

  When update a proxy with json
  """
  {
    "name" : "_proxy",
    "path" : "/proxy",
    "url" : "http://maps.googleapis.com/maps/api/geocode/json?address=SBO"
  }
  """
  Then response status should be 201

  When invoke a "GET" in url "/proxy"
  Then response status should be 200
  And response body should contains "SBO"
