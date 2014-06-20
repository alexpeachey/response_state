# Response State

The Response State gem is an implementation of the Response State pattern by @brianvh

## Installation

Add this line to your application's Gemfile:

    gem 'response_state'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install response_state

## Usage

### ResponseState::Service

Create a service class and subclass ResponseState::Service.

```ruby
class MyService < ResponseState::Service
  def initialize(param)
    @param = param
  end

  def call(&block)
    # do some work
    yield send_state(:success)
  end
end
```

You must implement a `call` method.
Your call method should yield with a `ResponseState::Response`.
The response can be generated with a helper method `send_state` in your service class.

You can optionally declare and restrict the set of valid states for your service's responses.
The service will use this set of states when generating the response with the `send_state` method.

```ruby
class MyService < ResponseState::Service
  response_states :success, :failure

  def call(&block)
    # do some work
    yield send_state(:success)
  end
end
```


### Response

A `ResponseState::Response` can take up to 4 arguments but must at least have the first argument which is the state of the response. In addition it can take a message, a context, and a set of valid states. The message by convention should
be a string but there are no restrictions. The context can be any object. The valid states should be an array of symbols
that are the allowed states. An exception will be thrown if initialized with a type of response that is not in the valid states if a set of valid states was specified.

```ruby
response = Response.new(:success, 'You win!', {an_important_value: 'some value'})
response.type    # :success
response.message # 'You win!'
response.context  # {an_important_value: 'some value'}

response.success { puts 'I succeeded' }  # I succeeded
response.failure { puts 'I failed' }     # nil

response = Response.new(:foo, 'FOO!', {}, [:success, :failure])
# exception => Invalid type of response: foo

response = Response.new(:success, '', {}, [:success, :failure])
response.foo { puts 'Not going to work' }
# exception => NoMethodError: undefined method `foo'
```

You can also choose to subclass `ResponseState::Response` and define valid states for all instances of that class.
If you want to only allow certain states, this is the prefered method,
rather than passing the 4th argument in the construction of the object.

```ruby
class MyResponse < ResponseState::Response
  valid_states :success, :failure
end

response = MyResponse.new(:success)
response.success { puts 'I succeeded' }  # I succeeded
response.failure { puts 'I failed' }     # nil
response.foo { puts 'Not going to work' }
# exception => NoMethodError: undefined method `foo'
```

### Your service API

Your service can now be used as such:

```ruby
MyService.('Some param') do |response|
  response.success { puts 'I was successful.' }
  response.failure { puts 'I failed.' }
end
```

If your service or the response itself restrict the response to a specific set
of states, you can ensure all states have been handled by placing a call
to `unhandled_states` at the end of your response block. This will yield an array of
unhandled states to the given block if there are any unhandled states.

```ruby
MyService.('Some param') do |response|
  response.success { puts 'I was successful.' }
  response.failure { puts 'I failed.' }
  response.unhandled_states { |states| raise "You didn't handle #{states.join(', ')}" }
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
