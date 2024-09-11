  #  Activity
    #Send request to /api/accounts/add-primary-account
    # Status should be 201 and response contain email entity
  @Regression
  Feature: Create Account Feature
  @NewAccount_1
    Scenario: Create new account
      Given url BASE_URL
      Given path "/api/accounts/add-primary-account"
      * def email = "mohammad_instructor2517@tekschool.us"
      Given request
        """
        {
          "email": "#(email)",
          "firstName": "Mohammad",
          "lastName": "Shokriyan",
          "title": "Mr.",
          "gender": "MALE",
          "maritalStatus": "Single",
          "employmentStatus": "Software Developer",
          "dateOfBirth": "1985-02-27"
        }
        """
      When method post
      Then print response
      Then status 201
      Then assert response.email == email
      * def createdAccountId = response.id
      * def tokenGenerationResult = callonce read('GenerateSupervisorToken.feature')
      * def validToken = "Bearer " + tokenGenerationResult.response.token
      Given path "/api/accounts/delete-account"
      Given param primaryPersonId = createdAccountId
      Given header Authorization = validToken
      When method delete
      Then status 202

