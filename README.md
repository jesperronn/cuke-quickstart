CUCUMBER TESTING
================

This /cucumber folder is used for testing our frontend code/javascript.


USAGE
=====

Run all tests against localhost:3000

    $ cucumber 



CREATING YOUR OWN SUITE
=======================

Create your own test suite `myownapp` so that you can run

    $ cucumber -p myownapp


### 1. add new in `cucumber.yml`

First you will add a new profile 'myownapp' in `cucumber.yml`

### 2. new environment in "testdata"

Now, copy and modify the /testdata/*.yml file to fit your need

### 3. add a feature file to test your app. example

    features/my_login.feature

    Feature: Login and separation of users
      As a paranoid user of 'myOwnApp'
      I want to ensure I work on the correct user



      Scenario: Customer code must follow the user logged in
        Given I go to the /login page
        And I fill in "username" with "testuser33"
        And I fill in "password" with "pass"
        And I press "Login"
        Then I should be on the frontpage
        And I should see "Logged in as testuser33"
        And I should see "Working on customer code: 113112"

As the example shows, you can start with using predefined steps and get going. 




INSTALLATION PREREQUISITES
==========================

### Setup Phantomjs (Step 1)

    $ brew install phantomjs

### Setup NodeJs and libraries (Step 2)
    
    $ brew install nodejs

    $ make install

### Setup Ruby and libraries (Step 3)

  1) Install ruby via RVM -- see explanation at http://rvm.io/

  2) run gem install bundler

  3) run `bundle install`



Now you can verify your setup with `make test`
  

EDITOR CONFIGURATION
--------------------

You may find helpful
Syntax highlighting of cucumber.features and steps (for Sublime Text):


    cd ~/.config/sublime-text-2/Packages/
    git clone https://github.com/npverni/cucumber-sublime2-bundle.git


Autocompletion of cucumber snippets (for Sublime Text):

    cd ~/.config/sublime-text-2/Packages/
    git clone https://github.com/jesperronn/sublimetext-cucumber-snippets.git

Restart Sublime Text after installing





