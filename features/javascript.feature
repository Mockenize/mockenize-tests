# encode: utf-8
Feature: Test JavaScript features

Scenario Outline: Create and execute a mock with JavaScript

  Given a JavaScript code with name "js_test" and source code
  """
  function func(path, body, obj) {
    obj.msg = "_ok";
    return obj
  }
  """
  Then response status should be 204

  Given a mock with json
  """
  {
    "path" : "/test",
    "method" : "<method>",
    "status" : <status>,
    "scriptName" : "js_test"
  }
  """
  Then response status should be 201

  When invoke a "<method>" in url "/test" with value
  """
  {"msg":"ok"}
  """
  Then response status should be <status>
  And response body should be
  """
  {"msg":"_ok"}
  """

  Examples:
  | status | method |
  | 200    | POST   |
  | 500    | POST   |
  | 200    | DELETE |
  | 500    | DELETE |
  | 200    | PUT    |
  | 500    | PUT    |

Scenario Outline: Update and execute a mock with JavaScript

  GivenScenario Create and execute a mock with JavaScript
  When update a JavaScript code with name "js_test" and source code
  """
  function func(path, body, obj) {
    obj.msg = "_ok_update";
    return obj
  }
  """
  Then response status should be 204


  When invoke a "<method>" in url "/test" with value
  """
  {"msg":"ok"}
  """
  And response body should be
  """
  {"msg":"_ok_update"}
  """

  Examples:
  | status | method |
  | 200    | POST   |
  | 500    | POST   |
  | 200    | DELETE |
  | 500    | DELETE |
  | 200    | PUT    |
  | 500    | PUT    |
