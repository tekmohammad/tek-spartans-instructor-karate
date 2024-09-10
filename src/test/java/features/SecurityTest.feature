Feature: API testing for Security Functions

  Background: Setup test
    Given url 'https://dev.insurance-api.tekschool-students.com'
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
    Then status 200

  @US_2
  Scenario: Valid token with invalid credential
    Given request
      """
      {
        "username": "supervisorx",
        "password": "tek_supervisor"
      }
      """
    When method post
    Then status 404