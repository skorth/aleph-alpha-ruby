# Aleph Alpha Ruby Client

<p align="center">
  <img src="https://i.imgur.com/FSM2NNV.png" width="50%" />
</p>

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

#### Custom timeout or base URI

The default timeout for any request using this library is 120 seconds. You can change that by passing a number of seconds to the `request_timeout` when initializing the client. You can also change the base URI used for all requests.

```ruby
client = AlephAlpha::Client.new(
    access_token: "access_token_goes_here",
    uri_base: "https://other-api-endpoint.aleph-alpha.com",
    request_timeout: 240
)
```

or when configuring the gem:

```ruby
AlephAlpha.configure do |config|
    config.access_token = ENV.fetch("ALEPH_ALPHA_ACCESS_TOKEN")
    config.uri_base = "https://other-api-endpoint.aleph-alpha.com" # Optional
    config.request_timeout = 240 # Optional
end
```

### Models

There are different models that can be used to generate text. For a full list:

```ruby
client.models.list
```

### Current API version

```ruby
client.version
```

### Tokens

#### Get a list of issued API tokens

```ruby
client.tokens.list
```

#### Create a new API token

```ruby
client.tokens.create(
  parameters: {
    description: "token used on my laptop"
  }
)
```

#### Delete an API token

```ruby
client.tokens.delete(id: 123)
```

### Users

#### Get settings for own user

```ruby
client.users.me
```

#### Change settings for own user

```ruby
client.users.settings(
  parameters: {
    out_of_credits_threshold: 0
  }
)
```

#### Query Recent Usage

```ruby
client.users.usage
```

### Tasks

#### Completion

```ruby
client.completions(
  parameters: {
    model: "model name",
    prompt: "some text",
    maximum_tokens: 64
  }
)
```

#### Embeddings

```ruby
client.embeddings(
  parameters: {
    model: "model name",
    prompt: "some text",
    layers: [
      0,
      1
    ],
    tokens: false,
    pooling: [
      "max"
    ]
  }
)
```

#### Semantic Embeddings

```ruby
client.semantic_embeddings(
  parameters: {
    model: "model name",
    prompt: "some text",
    representation: "symmetric",
    compress_to_size: 128
  }
)
```

#### Evaluate

```ruby
client.evaluate(
  parameters: {
    model: "model name",
    prompt: "some text",
    completion_expected: "another text"
  }
)
```

#### Explanation

```ruby
client.explain(
  parameters: {
    model: "model name",
    hosting: "aleph-alpha",
    prompt: "some text",
    target: "string",
    control_factor: 0.1,
    contextual_control_threshold: 0,
    control_log_additive: true,
    postprocessing: "none",
    normalize: false,
    prompt_granularity: {
      type: "token",
      delimiter: "string"
    },
    target_granularity: "complete",
    control_token_overlap: "partial"
  }
)
```

#### Tokenize

```ruby
client.tokenize(
  parameters: {
    model: "model name",
    prompt: "some text",
    tokens: true,
    token_ids: true
  }
)
```

#### Detokenize

```ruby
client.detokenize(
  parameters: {
    model: model,
    token_ids: [
      556,
      48_741,
      247,
      2983,
      28_063,
      301,
      10_510,
      5469,
      17
    ]
  }
)
```

#### Q&A

```ruby
client.qa(
  parameters: {
    query: "some text",
    documents: [
      {
        text: "another text"
      }
    ]
  }
)
```

#### Summarize

```ruby
client.summarize(
  parameters: {
    model: "model name",
    document: {
      text: "Text about something..."
    }
  }
)
```

## Contributing

Initially, this gem is based on [ruby-openai](https://github.com/alexrudall/ruby-openai). I didn't want to reinvent the wheel and if possible have a similar API for convenience. Bug reports and pull requests are welcome on GitHub at <https://github.com/skorth/aleph-alpha-ruby>.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
