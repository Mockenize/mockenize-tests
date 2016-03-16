# encode: utf-8
Feature: Test Javascript features

Scenario Outline: Create and execute a mock with Javascript

  Given a Javascript code with name "<scriptName>" and source code
  """
  function func(testeee) {
    return testeee;
  }
  """
  Then response status should be 204

  Given a mock with json
  """
  {
    "path" : "<url>",
    "method" : "<method>",
    "status" : <status>,
    "body" : "<body>",
    "headers" : {
        "<header_key>" : "<header_value>"
    },
    "scriptName" : "<scriptName>"
  }
  """
  Then response status should be 201

  When invoke a "<method>" in url "<url>"
  Then response status should be <status>
  And response body should be "<body>"

  Examples:
  | status | url    | scriptName | body  | header_key   | header_value | method |
  | 200    | /test2  | js_test1   | body1 | Content-Type | text/plain   | POST   |
  | 500    | /test  | js_test2   | body2 | Content-Type | text/plain   | POST   |
  | 200    | /test  | js_test3   | body3 | Content-Type | text/plain   | GET    |
  | 500    | /test  | js_test4   | body4 | Content-Type | text/plain   | GET    |
  | 200    | /test  | js_test5   | body5 | Content-Type | text/plain   | DELETE |
  | 500    | /test  | js_test6   | body6 | Content-Type | text/plain   | DELETE |
  | 200    | /test  | js_test7   | body7 | Content-Type | text/plain   | PUT    |
  | 500    | /test  | js_test8   | body8 | Content-Type | text/plain   | PUT    |
