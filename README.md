# ResponsiveService

The ResponsiveService gem is at this point little more than a light wrapper on a suggested pattern
for implementing service classes.

## Installation

Add this line to your application's Gemfile:

    gem 'responsive_service'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install responsive_service

## Usage

### ResponsiveService

Create a service class, either your own or feel free to subclass from `ResponsiveService::ResponsiveService`.

```ruby
class MyService < ResponsiveService::ResponsiveService
  def call(&block)
    # do some work
    yield ResponsiveService::Response.new(:success)
  end
end
```

You must implement a `call` method if you subclass `ResponsiveService::ResponsiveService`.
Your call method should yield with a `ResponsiveService::Response`.

### Response

A `ResponsiveService::Response` can take up to 4 arguments but must at least have the first argument which is the type of the response. In addition it can take a message, a context, and a set of valid states. The message by convention should
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

You can also choose to subclass `ResponsiveService::Response` and define valid states for all instances of that class.

```ruby
class MyResponse < ResponsiveService::Response
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
service = MyService.new
service.call do |response|
  response.success { puts 'I was successful.' }
  response.failure { puts 'I failed.' }
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
