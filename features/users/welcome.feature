@javascript
Feature: Welcome script introduces Neotopia and allows login
  In order to get started using neotopia
  As a user
  I want be able to be guided to log in or sign up

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

@wip
Scenario: Michael listens to intro and decides it's not for him
  Given I visit Neotopia
  When I read "Welcome to Neotopia, are you new here?"
  Then I choose "Yes"
  When I read "How exciting, and what should I call you?"
  Then I answer "Michael"
  When I read "Do you need me to explain what Neotopia is"
  Then I choose "Explain away"
  When I read "Neotopia is a utopia"
  Then I choose "Why do that?"
  When I read "Perhaps you think everything about the society you come from is fine the way it is?"
  Then I choose "yes, it’s fine"
  When I read "I'm unable to offer you a tourist visa just now"
  Then I choose "ok"
  Then I'm redirected to "https://www.nytimes.com/"
