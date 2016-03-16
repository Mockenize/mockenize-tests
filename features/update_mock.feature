# encode: utf-8
Feature: Test update mock features

Scenario Outline: Update a mock

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

  When update an mock with json
  """
  {
    "path" : "<url2>",
    "method" : "<method>",
    "status" : <status2>,
    "body" : "<body2>",
    "headers" : {
        "<header_key>" : "<header_value2>"
    }
  }
  """
  Then response status should be 201

  When invoke a "<method>" in url "<url2>"
  Then response status should be <status2>
  And response body should be "<body2>"
  And response header should be contains a key "<header_key>" and value "<header_value2>"

  Examples:
  | status | status2 | url    | url2   | body | body2 | header_key   | header_value | header_value2    | method |
  | 200    | 500     | /test  | /test2 | OK   | {}    | Content-Type | text/plain   | application/json | POST   |
  | 500    | 200     | /test  | /test2 | Fail | {}    | Content-Type | text/plain   | application/json | POST   |
  | 200    | 500     | /test  | /test2 | OK   | {}    | Content-Type | text/plain   | application/json | GET    |
  | 500    | 200     | /test  | /test2 | Fail | {}    | Content-Type | text/plain   | application/json | GET    |
  | 200    | 500     | /test  | /test2 | OK   | {}    | Content-Type | text/plain   | application/json | DELETE |
  | 500    | 200     | /test  | /test2 | Fail | {}    | Content-Type | text/plain   | application/json | DELETE |
  | 200    | 500     | /test  | /test2 | OK   | {}    | Content-Type | text/plain   | application/json | PUT    |
  | 500    | 200     | /test  | /test2 | Fail | {}    | Content-Type | text/plain   | application/json | PUT    |
