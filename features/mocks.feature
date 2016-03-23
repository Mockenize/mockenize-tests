# encode: utf-8
Feature: Test mock features

Scenario: Create a mock
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

  When invoke a "POST" in url "/test"
  Then response status should be equal 202

  Scenario: Test multiple headers
    Given a mock with json
    """
    {
      "path" : "test",
      "method" : "POST",
      "status" : 202,
      "body" : "OK",
      "headers": {
        "Content-Type" : "application/json",
        "xgh": 1,
        "Header-2": 2
        }
      }
    }
    """
    Then response status should be equal 201

    When invoke a "POST" in url "/test"
    Then response header must contain a "Content-Type" and value "application/json"
    And  response header must contain a "xgh" and value "1"
    And  response header must contain a "Header-2" and value "2"
@wip
Scenario Outline: Create a mock and verify status, header and response body

  Given a mock with json
  """
  {
    "path" : "<url>",
    "method" : "<method>",
    "status" : <status>,
    "body" : {
        "msg" : "OK"
      },
    "headers": {
      "Content-Type" : "application/json"
      }
    }
  }
  """
  Then response body most contain "<url>"
  Then response status should be equal 201

  When invoke a "<method>" in url "<url>"
  Then response status should be equal <status>
  And response body should be equal
  """
  {
    "msg" : "OK"
  }
  """
  And response header must contain a "<header_key>" and value "<header_value>"

  Examples:
  | status | url    | header_key   | header_value     | method |
  | 200    | /test  | Content-Type | application/json | POST   |
  | 500    | /test  | Content-Type | application/json | POST   |
  | 200    | /test  | Content-Type | application/json | GET    |
  | 500    | /test  | Content-Type | application/json | GET    |
  | 200    | /test  | Content-Type | application/json | DELETE |
  | 500    | /test  | Content-Type | application/json | DELETE |
  | 200    | /test  | Content-Type | application/json | PUT    |
  | 500    | /test  | Content-Type | application/json | PUT    |

Scenario: Get all mocks
  Given a mock with json
  """
  {
    "path" : "test1",
    "method" : "POST",
    "status" : 202,
    "body" : "OK"
  }
  """
  Given a mock with json
  """
  {
    "path" : "test2",
    "method" : "POST",
    "status" : 202,
    "body" : "OK"
  }
  """
  Given a mock with json
  """
  {
    "path" : "test3",
    "method" : "POST",
    "status" : 202,
    "body" : "OK"
  }
  """
  Then response status should be equal 201

  When invoke a "GET" in url "/_mockenize/mocks"
  Then response status should be equal 200
  And response body most contain "/test1"
  And response body most contain "/test2"
  And response body most contain "/test3"

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
  Then response status should be equal <status>
  And response body should be equal "<body>"
  And response header must contain a "<header_key>" and value "<header_value>"

  When update an mock with json
  """
  {
    "path" : "<url2>",
    "method" : "<method>",
    "status" : <status2>,
    "body" : "<body2>",
    "headers" : {
        "<header_key>" : "<header_value>"
    }
  }
  """
  Then response status should be equal 201

  When invoke a "<method>" in url "<url2>"
  Then response status should be equal <status2>
  And response body should be equal "<body2>"
  And response header must contain a "<header_key>" and value "<header_value>"

  Examples:
  | status | status2 | url    | url2   | body | body2 | header_key   | header_value | method |
  | 200    | 500     | /test  | /test2 | OK   | { }   | Content-Type | text/plain   | POST   |
  | 500    | 200     | /test  | /test2 | Fail | { }   | Content-Type | text/plain   | POST   |
  | 200    | 500     | /test  | /test2 | OK   | { }   | Content-Type | text/plain   | GET    |
  | 500    | 200     | /test  | /test2 | Fail | { }   | Content-Type | text/plain   | GET    |
  | 200    | 500     | /test  | /test2 | OK   | { }   | Content-Type | text/plain   | DELETE |
  | 500    | 200     | /test  | /test2 | Fail | { }   | Content-Type | text/plain   | DELETE |
  | 200    | 500     | /test  | /test2 | OK   | { }   | Content-Type | text/plain   | PUT    |
  | 500    | 200     | /test  | /test2 | Fail | { }   | Content-Type | text/plain   | PUT    |

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
  Then response status should be equal 200

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
  Then response status should be equal 200

  When delete a mock with json
  """
  {
      "path" : "<url>",
      "method" : "<method>"
  }
  """
  Then response status should be equal 204

  When invoke a "<method>" in url "<url>"
  Then response status should be equal 404

  When invoke a "<method>" in url "<url2>"
  Then response status should be equal 200

  Examples:
  | url    | url2   | method |
  | /test  | /test2 | POST   |
  | /test  | /test2 | PUT    |
  | /test  | /test2 | GET    |
  | /test  | /test2 | DELETE |

Scenario: Delete empty multiple mocks
  When delete all mocks with json
  """
  []
  """
  Then response status should be equal 204

Scenario: Delete empty single mock
  When delete a mock with json
  """
  {}
  """
  Then response status should be equal 500

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
  Then response status should be equal 202

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
  Then response status should be equal 202

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
  Then response status should be equal 202

  When delete all mocks with json
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
  Then response status should be equal 204

  When invoke a "<method>" in url "<url1>"
  Then response status should be equal 404

  When invoke a "<method>" in url "<url2>"
  Then response status should be equal 404

  When invoke a "<method>" in url "<url3>"
  Then response status should be equal 202

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
  Then response status should be equal 201

  When invoke a "POST" in url "/test"
  Then response timeout should be equal 1

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
  Then response status should be equal 201

  When invoke a "POST" in url "/test"
  Then response timeout should be between 1 and 2
