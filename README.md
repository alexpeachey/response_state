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

Create a service class, either your own or feel free to subclass from `ResponsiveService::ResponsiveService`.

```ruby
class MyService < ResponsiveService::ResponsiveService
  def call(&block)
    # do some work
    yield ResponsiveService::Responder.new(:success)
  end
end
```

You must implement a `call` method if you subclass `ResponsiveService::ResponsiveService`.
Your call method should yield with a `ResponsiveService::Responder`.

A `ResponsiveService::Responder` can take up to 3 arguments but must at least have the first argument which is the type of the response. In addition it can take a message and a context. The message by convention should
be a string but there are no restrictions. The context can be any object.

```ruby
responder = Responder.new(:success, 'You win!', {an_important_value: 'some value'})
responder.type    # :success
responder.message # 'You win!'
resonder.context  # {an_important_value: 'some value'}
```

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
