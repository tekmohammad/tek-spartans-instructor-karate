Feature: API testing for Security Functions

  Background: Setup test
    Given url BASE_URL
    Given path '/api/token'

  @US_1
  Scenario: Valid token with valid credential
    Given request
      """
      {
        "username": "supervisor",
        "password": "tek_supervisor"
      }
      """
    When method post
    Then print response
    Then status 200
    Then assert response.username == "supervisor"

  @US_2
  Scenario Outline: Valid token with invalid credential
    Given request
      """
      {
        "username": "<username>",
        "password": "<password>"
      }
      """
    When method post
    Then print response
    Then status <statusCode>
    Then assert response.errorMessage == "<error>"

    Examples:
      | username    | password       | statusCode | error                      |
      | Supervisorx | tek_supervisor | 404        | User Supervisorx not found |
      | supervisor  | wrong password | 400        | Password not matched       |