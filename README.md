# Aleph Alpha Ruby
### Bundler

Add this line to your application's Gemfile:

```ruby
gem "aleph-alpha-ruby"
```

And then execute:

$ bundle install

### Gem install

Or install with:

$ gem install aleph-alpha-ruby

and require with:

```ruby
require "aleph-alpha"
```

## Usage

- Get your API token from [https://app.aleph-alpha.com/profile](https://app.aleph-alpha.com/profile)

### Quickstart

For a quick test you can pass your token directly to a new client:

```ruby
client = AlephAlpha::Client.new(access_token: "access_token_goes_here")
```

### With Config

```ruby
AlephAlpha.configure do |config|
  config.access_token = ENV.fetch("ALEPH_ALPHA_ACCESS_TOKEN")
end
```

Then you can create a client like this:

```ruby
client = AlephAlpha::Client.new
```

# TODO

- add all api endpoints
- tests

more to come!

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/skorth/aleph-alpha-ruby>. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/skorth/aleph-alpha-ruby/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Aleph Alpha project's codebases and issue trackers is expected to follow the [code of conduct](https://github.com/skorth/aleph-alpha-ruby/blob/main/CODE_OF_CONDUCT.md).
