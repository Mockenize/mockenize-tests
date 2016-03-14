# encode: utf-8
Feature: Single Mock
    Tests using basic features

Scenario Outline: Test status, header and response body

  Given a mock with json
  """
  {
    "path" : "<url>",
    "method" : "POST",
    "status" : <status>,
    "body" : "<body>",
    "headers" : {
        "<header_key>" : "<header_value>"
    }
  }
  """
  When invoke a POST in url "<url>"
  Then response status should be <status>
  And response body should be "<body>"
  And response header should be contains a key "<header_key>" and value "<header_value>"

  Examples:
  | status | url    | body | header_key   | header_value     |
  | 200    | /test  | OK   | Content-Type | application/json |
  | 500    | /test  | Fail | Content-Type | application/json |  
