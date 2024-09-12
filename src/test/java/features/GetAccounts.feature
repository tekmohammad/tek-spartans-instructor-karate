@Regression
Feature: Testing Get Accounts API

  @GetAccounts_1
  Scenario: Validate /api/accounts/get-all-accounts
    Given url BASE_URL
    Given path "/api/accounts/get-all-accounts"
    When method get
    Then status 401
    * def result = callonce read('GenerateSupervisorToken.feature')
    * def token = result.response.token
    Given path "/api/accounts/get-all-accounts"
    Given header Authorization = "Bearer " + token
    When method get
    Then status 200