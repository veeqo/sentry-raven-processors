# Additional Sentry Raven processors [![Build Status](https://travis-ci.com/veeqo/sentry-raven-processors.svg?branch=master)](https://travis-ci.com/veeqo/sentry-raven-processors)

List of processors:
1. `RavenProcessors::Fingerprint` - replaces '{{default}}' fingerprint with combination of error class name and its line from stack trace.
2. to be added

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sentry-raven-processors'
```

And then execute:

    $ bundle

## Usage

Activate processor in your raven initializer (e.g. `config/initializers/raven.rb`)

```ruby
Raven.configure do |config|
  config.processors += [RavenProcessors::Fingerprint]
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rspec spec` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/veeqo/sentry-raven-processors.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
