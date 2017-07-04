require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock
  c.filter_sensitive_data('some_api_token') { ENV['WERCKER_API_TOKEN'] }
  c.default_cassette_options = { record: :once }
  c.configure_rspec_metadata!
end
