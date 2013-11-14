@steptesting
Feature: Browsing steps verification
  In order to use my steps correctly with examples
  As a developer
  I want to know that all works as I expect


  Scenario: Navigation
    * I go to the frontpage
    * I should be on the frontpage
    * I should be on /
    * I click "link to page with form elements"
    * I should be on /forms.html

  Scenario: Not on Error page
    * I go to the frontpage
    * I am not on an error page

  Scenario: Error detection
    * I go to the frontpage
    * I am not on an error page
    * I go to /nonexisting
    * the page should have status 404

  
  Scenario: Visible text
    * I go to the frontpage
    * I should see "1. normal visible text"
    * I should see '1. normal visible text'
    * I should see /1. normal visible text/
    * I should see ignorecase "NorMAL ViSible TExT"
    * the text "1. normal visible text" should be visible
    * the text "1H. first hidden paragraph" should be hidden
    * I should not see "first hidden paragraph"
  
  
  Scenario: Count occurrences
    * I go to the frontpage
    * I should see 3 elements kind of "p"
    * I should see at least 3 elements kind of "p"
    * I should see 2 elements kind of "p" within section.first

  Scenario: Dom occurrences
    * I go to the frontpage
    * I should not see elements kind of "input"
  
  

  Scenario: Should not see hidden text
    * I go to the frontpage
    * I should not see "first hidden paragraph"
  

  @wip
  Scenario: Verify table based text
      * I go to the frontpage
      * I should see the following "table" table:
        | Column 1 | Column 2 | Column 3 | Column 4 |
        | 11       | 12       | 13       | 14       |
        | 21       | 22       | 23       | 24       |
        | 31       | 32       | 33       | 34       |

      * I should see "Column 1 Column 2 Column 3 Column 4 11 12 13 14 21 22 23 24 31 32 33 34" within table

