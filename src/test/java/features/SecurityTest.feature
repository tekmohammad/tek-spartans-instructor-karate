Feature: API testing for Security Functions

  Scenario: Valid token with valid credentials
    Given url 'https://dev.insurance-api.tekschool-students.com'
    Given path '/api/token'
    Given request
    """
      {
          "username": "supervisor",
          "password": "tek_supervisor"
      }
    """
    When method post
    Then status 200