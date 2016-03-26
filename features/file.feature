# encode: utf-8
Feature: Test upload and download file

Scenario: Upload a file

  Given a file with json
  """
  [{
    "path" : "test",
    "method" : "POST",
    "status" : 202,
    "body" : "OK"
  },
  {
    "path" : "test2",
    "method" : "GET",
    "status" : 202,
    "body" : "OK2"
  }
  ]
  """

  When I send the file
  Then response status should be equal 201

  When invoke a "POST" in url "/test"
  Then response status should be equal 202

Scenario: Download a file

  Given a mock with json
  """
  {
    "path" : "test",
    "method" : "POST",
    "status" : 202,
    "body" : "OK"
  }
  """
  Then response status should be equal 201

  When invoke a "GET" in url "/_mockenize/file/download"
  Then response status should be equal 200
  And response body most contain "test"
  And response body most contain "POST"
  And response body most contain "OK"
