# Email Predictor

Challenge accepted !

## Installation

```ruby
git clone git@github.com:gtroppee/mail_predictor.git
cd mail_predictor
bundle install
rake mp:setup
```

During the setup task, you will be prompted to choose your admin credentials for the padrino-admin interface.

## Running specs

```ruby
rspec spec
```

## Launching the app

```ruby
padrino start
```
And then go to http://localhost:3000

## Interacting with the app

There are two ways of using this app:

* Via the user interface
Quite straightforward, the user only has to fill in the form and submit it. Also, admins can go to the dashboard to play with the registered emails, and see the confidence index evolve according to the modifications made upon the database for instance.

* Via the console
```ruby
# Make a new instance of the Email class
email = Email.new(
    first_name: 'John',
    last_name: 'Doe', 
    domain_name: 'alphasights.com'
    )

# Pass to a predictor
predictor = Predictor.new(email)

# And send it the message you want
predictor.status 
#=> :predictions_successfully_made
predictor.predictions 
#=> [#<struct Prediction suggested_email_address="john.doe@alphasights.com", confidence_index=100>]
```

## 4 possible scenarios

* The domain name and the identity are known.
=> No predictions are made but the matching email address is returned.

* The domain name is known (i.e. there's at least one existing email with this domain in the database) but the identity of the person is unknown.
=> Predictions are made and each one has its own confidence index.

* The domain name is unknown.
=> No predictions are made but suggestions are returned, i.e. all four possible email addresses.

**Note: ** Suggestions are just like predictions but without the confidence index. From an architectural point of view they're only semantical variations of the same entity (one has a confidence index greater than zero, the other does not). 

* The information is invalid.
=> An error message is returned with an example of correctly formatted inputs.


## Observations

More observations (yay!), this time more about the structure and the main decisions that have been made throughout this challenge.

* About blocks
I mainly use the Jim Weirich's convention for blocks, meaning that `{}` are used when I care about the return value of the block, and `do ... end` are used when I just want to execute instructions.

* REPL vs TDD
As you'll see from the commit history, the majority of the tests have been coded after the global structure was sorted out. Two reasons for this:
 * I really wasn't sure how I was going to craft the app from the start
 * The REPL flow is just more natural to me : define > test > refine

* Action and Store models
    * **Actions** are more functional that object and basically consist of a class that performs only one action (even though its private api can be extensive) but still make sense as a class and not just a helper method. Plus they allow for a better code encapsulation, testing and readability.
    * **Stores** are classes which the existence make sense but that do basically nothing but storing data. In this app I mostly used structs rather than empty classes because they're easy to setup and clear. And if they were to evolve in the future and become real classes, the change would be transparent for the rest of the code.

* Why so GUI ?
'Cause it's pretty, shouldn't it suffice ? More seriously, it's always nice to develop a tool that can be used by almost everyone, not just a developer in the console. And while I was at it, I figured I might just as well make it functional, which it is !


## TL;DR

The answer to this challenge is:

**Peter Wong, alphasights.com**
=> peter.wong@alphasights.com

**Craig Silverstein, google.com**
=> educated guess: 
c.silverstein@google.com
craig.s@google.com

**Steve Wozniak, apple.com**
=> s.w@apple.com

**Barack Obama, whitehouse.gov**
=> wild guess: 
b.o@whitehouse.gov 
b.obama@whitehouse.gov 
barack.o@whitehouse.gov 
barack.obama@whitehouse.gov

