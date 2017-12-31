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
  When I read "Even if you like things about the society you come from, surely you see some room for improvement"
  Then I choose "no, it's perfect"
  When I read "Given that, a visit to Neotopia may not be of much intest to you, although you're still welcome of course."
  Then I choose "i think i'll pass, goodbye"
  Then I'm redirected to "https://www.google.com"

Scenario: Michael forgets that he's already signed up before
  Given an existing user "Michael"
  Given I visit Neotopia
  Then I read "Welcome to Neotopia, are you new here?"
  When I choose "Yes"
  Then I read "How exciting, and what should I call you?"
  When I answer "Michael"
  Then I read "Do you need me to explain what Neotopia is"
  When I choose "No, Get Started"
  Then I read "Ok Michael, I’m going to issue you with a tourist visa"
  When I fill in:
        | email    | michael@user.com |
        | password | grokthis         |
  Then I read "Hmmm, it looks like an account for that email address already exists. Are you sure you haven't been here before?"
  When I choose "I'll try a different address"
  Then I read "No worries Michael, give it another shot"
  When I fill in:
        | email    | michael@user.com |
        | password | grokthis         |
  Then I read "Hmmm, it looks like an account for that email address already exists. Are you sure you haven't been here before?"
  When I choose "Yes, that's me"
  Then I read "Lets try a log-in instead. Pop your existing username and password in below."
  When I fill in:
        | email    | michael@user.com |
        | password | grokthis         |
  Then I should see a header bar
   And I read "You're logged in"
