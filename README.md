[![Build Status](https://travis-ci.org/Originate/response_state.svg)](https://travis-ci.org/Originate/response_state)
[![Code Climate](https://codeclimate.com/github/Originate/response_state/badges/gpa.svg)](https://codeclimate.com/github/Originate/response_state)
[![Coverage Status](https://coveralls.io/repos/Originate/response_state/badge.png)](https://coveralls.io/r/Originate/response_state)

# Response State

The Response State gem is an implementation of the Response State pattern by @brianvh


## Installation

Add this line to your application's Gemfile:

    gem 'response_state'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install response_state


## About
The ResponseState pattern allows modeling and efficient interaction with
well structured outcomes of service calls.

As an example, an attempt to transfer funds between accounts
can succeed or fail in a variety of ways.
Each situation has to be dealt with individually.
Here is how efficient this situation can be modeled using the ResponseState
pattern provided by this Gem:

```ruby
AccountServices.transferFunds from: 'Checking', to: 'Savings', amount: 100 do |result|
  result.success { |txn| puts "transfer complete, confirmation number #{txn.id}" }
  result.pending { puts 'transfer pending user approval' }
  result.limit_exceeded { puts 'daily transaction limit exceeded' }
  result.insufficient_funds { puts 'not enough funds' }
  result.unknown_account { |account_name| puts "unknown account: #{account_name}" }
  result.unauthorized { puts 'please log in first' }
  result.other { |error| puts "Something went wrong: #{error.message}" }
end
```


## Usage

In order to return a ResponseState response from your method or function:
* create a ResponseState instance and let it parse the subscriptions of your callers
* call the method that represents the response you wish to return
  on your ResponseState instance


```ruby
def transferFunds from:, to:, amount:
  result = ResponseState.init(&block)
  if ...
    result.success txn
  elsif ...
    result.pending
  elsif ...
    result.limit_exceeded
  ...
end
```

You can call result methods multiple times,
thereby allowing streaming responses.

## Validations

By default, ResponseState allows subscription to and definition of any result,
and leaves it up to your integration tests to verify correct code behavior.

You can provide a list of valid outcomes to the `init` method to make
ResponseState throw exceptions if an unknown state is subscribed to or provided:

```ruby
  result = ResponseState.init(allowed_states: [:success, :pending, :limit_exceeded],
                              &block)
```
