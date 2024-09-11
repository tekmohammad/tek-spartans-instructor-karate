@Regression
Feature: Testing Account APIs

  Background: Setup tests
    Given url BASE_URL
    * def generateTokenResult = callonce read('GenerateSupervisorToken.feature')
    Then print generateTokenResult
    * def validToken = "Bearer " + generateTokenResult.response.token
    Given path "/api/accounts/get-account"
    Given header Authorization = validToken

  @Account_1
  Scenario: Testing /api/accounts/get-account

    * def accountId = 9479
    Given param primaryPersonId = accountId
    When method get
    Then status 200
    Then assert response.primaryPerson.id == accountId

  # Activity
  # Send request to /api/accounts/get-account with Account 55225522
  # Status code should be 404 and errorMessage = "Account with id 55225522 not found"
  @Account_2
  Scenario: Testing get-account with non-existing accoundId
    * def accountId = 55231
    Given param primaryPersonId = accountId
    When method get
    Then print response
    Then status 404
    Then assert response.errorMessage == "Account with id " + accountId +" not found"

