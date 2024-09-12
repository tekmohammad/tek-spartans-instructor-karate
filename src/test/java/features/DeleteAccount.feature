@Regression
Feature: Delete Account Testing

  @DeleteAccount
  Scenario: delete account with diferent users
    Given url BASE_URL
  * def createAccount = callonce read('CreateAccountWithRandomEmail.feature')
    * def newAccountId = createAccount.response.id
  * def operatorResult = callonce read('GenerateOperatorToken.feature')
    * def operatorToken = operatorResult.response.token
    Given path "/api/accounts/delete-account"
    Given param primaryPersonId = newAccountId
    Given header Authorization = "Bearer " + operatorToken
    When method delete
    Then status 403
    * def supervisorResult = callonce read('GenerateSupervisorToken.feature')
    * def supervisorToken = supervisorResult.response.token
    Given path "/api/accounts/delete-account"
    Given param primaryPersonId = newAccountId
    Given header Authorization = "Bearer " + supervisorToken
    When method delete
    Then status 202