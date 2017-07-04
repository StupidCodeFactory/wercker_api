require 'bundler/setup'
require 'wercker_api'
require 'rspec/collection_matchers'
require 'byebug'
require 'webmock'
require 'ap'

Dir['spec/support/**/*.rb'].each do |f|
  load(f)
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
