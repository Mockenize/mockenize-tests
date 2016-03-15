# encode: utf-8
Feature: Single Mock
    Tests using basic features

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

Scenario Outline: Delete a mock

  Given a mock with json
  """
  {
    "path" : "<url>",
    "method" : "<method>",
    "status" : 200,
    "body" : "response"
  }
  """
  When invoke a "<method>" in url "<url>"
  Then response status should be 200

  Given a mock with json
  """
  {
    "path" : "<url2>",
    "method" : "<method>",
    "status" : 200,
    "body" : "response"
  }
  """
  When invoke a "<method>" in url "<url2>"
  Then response status should be 200

  When delete a mock with json
  """
  [
    {
      "path" : "<url>",
      "method" : "<method>"
    }
  ]
  """
  Then response status should be 204

  When invoke a "<method>" in url "<url>"
  Then response status should be 404

  When invoke a "<method>" in url "<url2>"
  Then response status should be 200

  Examples:
  | url    | url2   | method |
  | /test  | /test2 | POST   |
  | /test  | /test2 | PUT    |
  | /test  | /test2 | GET    |
  | /test  | /test2 | DELETE |

  Scenario: Delete empty multiple mocks
  When delete a mock with json
  """
  []
  """
  Then response status should be 204

  Scenario Outline: Delete multiple mocks

    Given a mock with json
    """
    {
      "path" : "<url1>",
      "method" : "<method>",
      "status" : 202,
      "body" : "response"
    }
    """
    When invoke a "<method>" in url "<url1>"
    Then response status should be 202

    Given a mock with json
    """
    {
      "path" : "<url2>",
      "method" : "<method>",
      "status" : 202,
      "body" : "response"
    }
    """
    When invoke a "<method>" in url "<url2>"
    Then response status should be 202

    Given a mock with json
    """
    {
      "path" : "<url3>",
      "method" : "<method>",
      "status" : 202,
      "body" : "response"
    }
    """
    When invoke a "<method>" in url "<url3>"
    Then response status should be 202

    When delete a mock with json
    """
    [
      {
        "path" : "<url1>",
        "method" : "<method>"
      },
      {
        "path" : "<url2>",
        "method" : "<method>"
      }
    ]
    """
    Then response status should be 204

    When invoke a "<method>" in url "<url1>"
    Then response status should be 404

    When invoke a "<method>" in url "<url2>"
    Then response status should be 404

    When invoke a "<method>" in url "<url3>"
    Then response status should be 202

    Examples:
    | url1    | url2   | url3   |  method  |
    | /test1  | /test2 | /test3 |  POST   |
    | /test1  | /test2 | /test3 |  PUT    |
    | /test1  | /test2 | /test3 |  GET    |
    | /test1  | /test2 | /test3 |  DELETE |

  Scenario: Test response timeout
    Given a mock with json
    """
    {
      "path" : "/test",
      "method" : "POST",
      "status" : 200,
      "body" : "OK",
      "timeout" : 1
    }
    """
    Then response status should be 201

    When invoke a "POST" in url "/test"
    Then response timeout should be 1

    Scenario: Test response timeout interval
      Given a mock with json
      """
      {
        "path" : "/test",
        "method" : "POST",
        "status" : 200,
        "body" : "OK",
        "minTimeout" : 1,
        "maxTimeout" : 2
      }
      """
      Then response status should be 201

      When invoke a "POST" in url "/test"
      Then response timeout should be between 1 and 2
