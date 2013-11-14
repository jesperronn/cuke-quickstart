@steptesting
Feature: Browsing steps verification
  In order to use my steps correctly with examples
  As a developer
  I want to know that all works as I expect


  @wip
  Scenario: CSS capitalized text
    * I go to /capitalized.html
    * I should see "first tab second tab third tab" within .unstyled
    #NOTE I am not sure this is correct since DOM is lowercased
    * I should see "First Tab Second Tab Third Tab" within .capitalized


