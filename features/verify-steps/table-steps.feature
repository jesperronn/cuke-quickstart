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


  Scenario: Verify table based text
      * I go to the frontpage
      * I should see the following "table" table:
        | Column 1 | Column 2 | Column 3 | Column 4 |
        | 11       | 12       | 13       | 14       |
        | 21       | 22       | 23       | 24       |
        | 31       | 32       | 33       | 34       |

      * I should see "Column 1 Column 2 Column 3 Column 4 11 12 13 14 21 22 23 24 31 32 33 34" within table
