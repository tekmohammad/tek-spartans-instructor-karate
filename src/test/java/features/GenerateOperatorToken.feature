@Regression
Feature: Generating Token with Supervisor User

  Scenario: Generate Valid token
    Given url BASE_URL
    Given path "/api/token"
    Given request
      """
      {
        "username": "operator_readonly",
        "password": "Tek4u2024"
      }
      """
    When method post
    Then status 200