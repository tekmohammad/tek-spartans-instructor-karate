@Regression @AddPhoneAndCar
Feature: Testing adding car and phone to an account

  Background: setup tests
    Given url BASE_URL
    * def createAccountResult = callonce read('CreateAccountWithRandomEmail.feature')
    * def newAccountId = createAccountResult.response.id
    * def tokenResult = callonce read('GenerateSupervisorToken.feature')
    * def token = "Bearer " + tokenResult.response.token
  @AddPhone
  Scenario: Testing Adding Phone
    Given path "/api/accounts/add-account-phone"
    Given param primaryPersonId = newAccountId
    Given header Authorization = token
    Given request
      """
      {
        "phoneNumber": "2023034040",
        "phoneExtension": "",
        "phoneTime": "Anytime",
        "phoneType": "Mobile"
      }
      """
    When method post
    Then print response
    Then status 201
    And assert response.phoneNumber == "2023034040"

    @AddCar
    Scenario: Add car to an Account
      Given path "/api/accounts/add-account-car"
      Given param primaryPersonId = newAccountId
      Given header Authorization = token
      Given request
      """
      {
        "make": "Ford",
        "model": "Mustang",
        "year": "2024",
        "licensePlate": "ABCD1234"
      }
      """
      When method post
      Then print response
      Then status 201
      Then assert response.make == "Ford"