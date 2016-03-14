# encode: utf-8
Feature: Single Mock
    Tests using basic features

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
  When invoke a "<method>" in url "<url>"
  Then response status should be <status>
  And response body should be "<body>"
  And response header should be contains a key "<header_key>" and value "<header_value>"

  Examples:
  | status | url    | body | header_key   | header_value     | method |
  | 200    | /test  | OK   | Content-Type | application/json | POST   |
  | 500    | /test  | Fail | Content-Type | application/json | POST   |
  | 200    | /test  | OK   | Content-Type | application/json | GET    |
  | 500    | /test  | Fail | Content-Type | application/json | GET    |
  | 200    | /test  | OK   | Content-Type | application/json | DELETE |
  | 500    | /test  | Fail | Content-Type | application/json | DELETE |
  | 200    | /test  | OK   | Content-Type | application/json | PUT    |
  | 500    | /test  | Fail | Content-Type | application/json | PUT    |
