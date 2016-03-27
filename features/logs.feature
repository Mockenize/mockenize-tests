# encode: utf-8
Feature: Test log Feature

Scenario: Finding a specific log

  Given a mock with json
  """
  {
    "path" : "/log/tst",
    "method" : "POST",
    "status" : 202,
    "body" : "OK"
  }
  """
  Then response status should be equal 201

  When invoke a "POST" in url "/log/tst" with value
  """
  {
    "key" : "value"
  }
  """
  Then response status should be equal 202

  When get a log with these filters
  """
  {
    "path" : "/log/tst",
    "method": "POST"
  }
  """
  Then response status should be equal 200
  And response body most contain "/log/tst"
  And response body most contain "key"
  And response body most contain "value"
