[![wercker status](https://app.wercker.com/status/15fd697b0b3ff854e408a5c256e6737b/s/master "wercker status")](https://app.wercker.com/project/byKey/15fd697b0b3ff854e408a5c256e6737b)
[![Code Climate](https://codeclimate.com/github/StupidCodeFactory/wercker_api/badges/gpa.svg)](https://codeclimate.com/github/codeclimate/codeclimate)
[![Test Coverage](https://codeclimate.com/github/StupidCodeFactory/wercker_api/badges/coverage.svg)](https://codeclimate.com/github/codeclimate/codeclimate/coverage)
# WerckerAPI

Thin ruby wrapper around [wercker API](http://devcenter.wercker.com/docs/api)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'wercker_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wercker_api

# Usage #

Generate an API token and either pass it as an argument to the `WerckerAPI::Client` or use the environment variable WERCKER\_API\_TOKEN
```ruby

    client = WerckerAPI::Client.new(token)
    client.applications('StupidCodeFactory') # => ApplicationCollection

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/wercker_api.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
