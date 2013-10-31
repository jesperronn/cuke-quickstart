CUCUMBER TESTING
================

This /cucumber folder is used for testing frontend code/javascript.
I wanted a **quick start** where everything is set up and works.

Use this project as a template so you can easily get started.
You basically copy this into your project, add your own .feature 
files, and you're done.

Included in this project

   * Phantomjs for fast headless browser testing
   * A set of standard ready-to-use Cucumber steps (should covers 80% of your need)

Worth of notice:
 
  * Saves a screenshot of every failing test (saves in test-results/screenshots)
  * Logs http requests in a logfile -- you can easily add to the logfile what you need

Most of these things are not new -- I just decided to collect them in one package easy to reuse.



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


AVAILABLE COMMANDS
==================

These commands are good to familiarize

    $ node steptesting/server.js

Starts a simple server on localhost:3000 with flat html pages that phantomjs runs against

    $ cucumber -p steptesting

Runs the cucumber test suite against the running simple server. Suite takes just a few seconds to run on my machine


    $ cucumber -p steptesting -p stepdefs

Shows which step_definitions are actually found in the cucumber .feature files.
Simple form of coverage -- you can see which steps are not used by tests yet.


    $ make test

Will run the server and the test suite. if all goes well, it kills the server afterwards

    $ make install

Will install the npm packages required to run


    $ lsof -i :3000

Will tell you the process id if the server is still running. (then you can kill it)



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





