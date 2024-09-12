@Regression
Feature: Testing profile section

  @Profile
  Scenario Outline: testing profile section with diferent user
    Given url BASE_URL
    Given path "/api/token"
    Given request
      """
      {
        "username": "<username>",
        "password": "<password>"
      }
      """
    When method post
    Then status 200
    * def token = response.token
    Given path "/api/user/profile"
    Given header Authorization = "Bearer " + token
    When method get
    Then status 200
    Then assert response.accountType == "<accountType>"

    Examples:
      | username          | password       | accountType |
      | supervisor        | tek_supervisor | CSR         |
      | operator_readonly | Tek4u2024      | CSR         |
      | mohammad25361     | mohammad25361  | CUSTOMER    |

