@javascript
Feature: First time visitor can sign up as a tourist
  In order to visit Neotopia
  As a user
  I want be able to sign up

Scenario: Michael signs up
  Given I visit Neotopia
  When I read "Welcome to Neotopia, are you new here?"
  Then I choose "Yes"
  When I read "How exciting, and what should I call you?"
  Then I answer "Michael"
  When I read "Do you need me to explain what Neotopia is"
  Then I choose "No, Get Started"
  When I read "Ok Michael, I’m going to issue you with a tourist visa"
   And I fill in:
        | email    | michael@user.com |
        | password | grokthis         |
  Then I should see a header bar
   And I read "You're logged in"


