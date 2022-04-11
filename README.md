# Sentry::Sanitize

This gem is extracting the old Raven client side sanitization helpers that existed pre-4.0 of the `sentry-ruby` gem.

https://github.com/getsentry/sentry-ruby/issues/1140

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sentry-sanitize'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install sentry-sanitize

## Usage

Inside your Sentry initializer you should add this:

```
Sentry.init do |config|
    # your other Sentry config options go here

    sanitizer = Sentry::Sanitize::Processor::CustomSanitizeData.new(Rails.application.config.filter_parameters.map(&:to_s))

    config.before_send = lambda do |event, hint|
      # Overrides the event level with custom level based on exception raised
      event.level = ErrorReporting.level(hint[:exception], event.level)

      event.to_hash.tap do |event_hash| # event needs to be a Hash for sanitizer to work
        if (request = event_hash[:request]).present?
          request[:cookies] = nil
          sanitizer.process(request)
        end
      end
    end
end
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/airtasker/sentry-sanitize. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/airtasker/sentry-sanitize/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Sentry::Sanitize project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/airtasker/sentry-sanitize/blob/master/CODE_OF_CONDUCT.md).
