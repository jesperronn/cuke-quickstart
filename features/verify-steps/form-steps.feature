@steptesting
Feature: Form steps verification
  In order to use my steps correctly with examples
  As a developer
  I want to know that all works as I expect


  Scenario: Fill in standard form elements
    Given I go to /forms.html
    * I should see "Account Number"
    * I fill in the following:
     | Account Number                   | 5002       |
     | Expiry date                      | 2009-11-01 |
     | Wants Email?                     |            |
     | Sex                   (select)   | Male       |
     | Accept user agreement (checkbox) | check      |
     | Send me letters       (checkbox) | uncheck    |
     | Radio 1               (radio)    | choose     |
     | Avatar                (file)     | avatar.jpg |
    * I should verify content of the following fields:
     | label, name or id                | value      |
     | Account Number                   | 5002       |
     | Expiry date                      | 2009-11-01 |
     | Wants Email?                     |            |
     | Sex                              | m          |
     | Radio 1                          | p1         |
    * the "Accept user agreement" checkbox should be checked
    * the "Send me letters" checkbox should not be checked
    * the "Account Number" field should contain "5002"
    * the "account-number" field should contain "5002"
    * the "expdate" field should contain "2009-11-01"
    * I fill in "Wants Email?" with ""
    * the "Wants Email?" field should contain "^$"
    * the "Wants Email?" field should be empty

  Scenario: Field should not contain
    Given I go to /forms.html
    * the "expdate" field should not contain "2009-12"
    * the "expiry-date" field should not contain "2009-11-01"

  Scenario: Verify selectboxes
    Given I go to /forms.html
    * the select "Sex" should have the following options:
      | Male   |
      | Female |


  Scenario: Verify date input fields 
    Given I go to /forms.html
    * I fill in "Expiry date" with today plus 2
    * the "Expiry date" field should contain "2014-10-30"
    * the "Expiry date" field should not be empty


  @ignore @fails  
  Scenario: Hidden fields
    Given I go to /forms.html
    # Unable to find field "hidden-id" (Capybara::ElementNotFound)
    * the invisible field "hidden-name" should contain "the hidden stuff"
    * the invisible field "hidden-id" should contain "the hidden stuff"

  @ignore @fails  
  Scenario: Hidden textareas
    Given I go to /forms.html
    * the invisible field "hidden-name" should contain:
      """
      the hidden stuff
      """
    * the invisible field "hidden-textarea" should contain:
      """
      the hidden stuff
      """



