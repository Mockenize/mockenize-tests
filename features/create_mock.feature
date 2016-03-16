# encode: utf-8
Feature: Test creation mock features

Scenario: Test create a mock
  Given a mock with json
  """
  {
    "path" : "/test",
    "method" : "POST",
    "status" : 200,
    "body" : "OK"
  }
  """
  Then response status should be 201

Scenario Outline: Test status, header and response body

  Given a mock with json
  """
  {
    "path" : "<url>",
    "method" : "<method>",
    "status" : <status>,
    "body" : "<body>",
    "headers" : {
        "<header_key>" : "<header_value>"
    }
  }
  """
  Then response status should be 201

  When invoke a "<method>" in url "<url>"
  Then response status should be <status>
  And response body should be "<body>"
  And response header should be contains a key "<header_key>" and value "<header_value>"

  Examples:
  | status | url    | body | header_key   | header_value | method |
  | 200    | /test  | OK   | Content-Type | text/plain   | POST   |
  | 500    | /test  | Fail | Content-Type | text/plain   | POST   |
  | 200    | /test  | OK   | Content-Type | text/plain   | GET    |
  | 500    | /test  | Fail | Content-Type | text/plain   | GET    |
  | 200    | /test  | OK   | Content-Type | text/plain   | DELETE |
  | 500    | /test  | Fail | Content-Type | text/plain   | DELETE |
  | 200    | /test  | OK   | Content-Type | text/plain   | PUT    |
  | 500    | /test  | Fail | Content-Type | text/plain   | PUT    |
