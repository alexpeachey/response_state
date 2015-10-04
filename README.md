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
The ResponseState pattern models more facetted method results
than the currently used simple return values.

In particular, ResponseState results represent
the different possible outcomes of the method's algorithm,
each one with its own type of data payload.

As an example, here is how readable a service that transfers funds between accounts
can be consumed using the ResponseState pattern:

```ruby
AccountServices.transferFunds from: 'Checking', to: 'Savings', amount: 100 do |result|
  result.success { |txn| puts "transfer complete, confirmation number #{txn.id}" }
  result.pending { puts 'transfer pending user approval' }
  result.limit_exceeded { puts 'daily transaction limit exceeded' }
  result.insufficient_funds { puts 'not enough funds' }
  result.unknown_account { |account_name| puts "unknown account given: #{account_name}" }
  result.unauthorized { puts 'please log in first' }
  result.other { |error| puts "Something went wrong: #{error.message}" }
end
```


## Usage

In order to return a ResponseState response from your method or function,
simply instantiate a ResponseState instance using `ResponseState.init`
with the block given to your method, then call the method that represents
the response you wish to return on it.


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

You can return multiple results, or the same result multiple times,
thereby allowing streaming responses.

By default, ResponseState allows subscription to and definition of any result.
If you want to verify that only valid outcomes are subscribed to and returned
by your method, you can provide a list of valid outcomes to the `init` method,
like so:

```ruby
  result = ResponseState.init(allowed_states: [:success, :pending, :limit_exceeded],
                              &block)
```

The ResponseState instance then throws exceptions if cliens subscribe to an
unknown response type, or if the method tries to return an unknown response type.
