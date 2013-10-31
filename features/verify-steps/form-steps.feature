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
    * the "Wants Email?" field should be empty

  Scenario: Field should not contain
    Given I go to /forms.html
    * the "expdate" field should not contain "2009-12"
    * the "expiry-date" field should not contain "2009-11-01"

  Scenario: Field should not be empty
    Given I go to /forms.html
    * the "Expiry date" field should be empty
    #@ignore @fails
    #* the "Expiry date" field should not be empty



  Scenario: Verify selectboxes
    Given I go to /forms.html
    * the select "Sex" should have the following options:
      | Male   |
      | Female |


  Scenario: Verify date input fields 
    Given I go to /forms.html
    And today is "2012-10-01"

    * I fill in "Expiry date" with today plus 2
    * the "Expiry date" field should contain "03/10/2012"
    * I fill in "Expiry date" with today plus 31 with dot-format
    * the "Expiry date" field should contain "01.11.2012"


    Scenario: Verify click on button
      Given I go to /forms.html
      * I should see "Press this button to remove this line with button"
      * I press "Press this button"
      * I should not see "Press this button"

    
    @ignore @fails
    Scenario: Verify click on input[type=button]
      Given I go to /forms.html
      #* I should see "Press this other button to remove this line"
      * I should see "Press this other button"
      * I should see " to remove this line with input[button]"
      * I press "Press this other button"
      * I should not see "Press this other button"

    
    


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



