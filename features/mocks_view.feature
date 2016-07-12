# encode: utf-8
Feature: Test mock features in view

  Background:
    Given that there is no test

  Scenario: Create a mock
    Given a mock clicking the create button
      And path "/test"
      And method "POST"
      And status "202"
      And body "{}"

     When I save this mock
     Then screen should be changed to mocks
      And my mock should be contained in the list.

     When invoke a "POST" in url "/test"
     Then response status should be equal 202

  Scenario: Delete a mock
    Given a mock
     When I click in delete button
      And I choice yes option
     Then screen should be changed to mocks
      And my mock should not be contained in the list.
  
