@javascript @wip
Feature: Returning users can log in
  In order to continue to explore Neotopia
  As a user
  I want be able to log in

Scenario: Michael logs in to his existing account
  Given an existing user "Michael"
  Given I visit Neotopia
  When I read "Welcome to Neotopia, are you new here?"
  Then I choose "No"
  When I read "I’ll just need you to identify yourself"
  Then I fill in:
        | email    | michael@user.com |
        | password | grokthis         |
  Then I should see a header bar
   And I read "You're logged in"

