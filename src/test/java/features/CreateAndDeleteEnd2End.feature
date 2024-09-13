@Regression
Feature: End 2 Ending Testing Create to Delete and Account

  @End2EndAccount
  Scenario: successfully delete and account
    Given url BASE_URL
    * def createAccount = callonce read('CreateAccountWithRandomEmail.feature')
    * def newAccountId = createAccount.response.id
    * def supervisorToken = callonce read('GenerateSupervisorToken.feature')
    * def token = "Bearer " + supervisorToken.response.token
    Given path "/api/accounts/get-account"
    Given header Authorization = token
    Given param primaryPersonId = newAccountId
    When method get
    Then print response
    Then status 200
    And assert response.primaryPerson.id == newAccountId
    And assert response.primaryPerson.email == createAccount.response.email
    And assert response.primaryPerson.gender == createAccount.response.gender
    And assert response.primaryPerson.firstName == createAccount.response.firstName

    Given path "/api/accounts/delete-account"
    Given param primaryPersonId = newAccountId
    Given header Authorization = token
    When method delete
    Then status 202

    Given path "/api/accounts/delete-account"
    Given param primaryPersonId = newAccountId
    Given header Authorization = token
    When method delete
    Then print response
    Then status 404
    Then assert response.errorMessage == "Account with id " + newAccountId + " not exist"
