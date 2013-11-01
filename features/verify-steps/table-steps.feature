@steptesting
Feature: Table steps verification
  In order to use my steps correctly with examples
  As a developer
  I want to know that all works as I expect



Scenario: Verify definition lists (DL)
  Given I am on the frontpage

  Then I should see the following ".definition-list" description list:
    | term 1: | description 1 |
    | term 2  | description 2 |
    | term 3  | description 3 |


  
  