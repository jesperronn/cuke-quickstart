@steptesting
Feature: Test debug features
  As a developer
  I want to quickly bisect and troubleshoot so that I can get my work done


  Scenario: screenshot and save
    Given I go to /forms.html
    * I take a screenshot named my_funny_screenshot

  Scenario: show page screenshot and html
    Given I go to /forms.html
    * show me the page  

  #debug step works but locks the other tests so don't use it normally
  @ignore 
  Scenario: I open a debug browser
    Given I go to /forms.html
    * I open the debug browser

  Scenario: network traffic
    Given I go to /forms.html
    * I log the network traffic for the page

