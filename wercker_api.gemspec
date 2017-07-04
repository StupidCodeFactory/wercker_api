# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "wercker_api/version"

Gem::Specification.new do |spec|
  spec.name          = "wercker_api"
  spec.version       = WerckerAPI::VERSION
  spec.authors       = ["yann marquet"]
  spec.email         = ["ymarquet@gmail.com"]

  spec.summary       = %q{interact with wercker API.}
  spec.description   = %q{interact with wercker API, Deeper integration with wercker.}
  spec.homepage      = "https://github.com/StupidCodeFactory/wercker_api"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = 'https://rubygems.org'
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'virtus', '~> 1.0.5'
  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-collection_matchers', '~> 1.1.3'
  spec.add_development_dependency 'vcr', '~> 3.0.3'
  spec.add_development_dependency 'gem-release', '~> 1.0.0'
  spec.add_development_dependency 'webmock', '~> 3.0.1'
  spec.add_development_dependency 'byebug', '~> 9.0.6'
  spec.add_development_dependency 'awesome_print', '~> 1.8.0'
  spec.add_development_dependency 'simplecov', '~> 0.14.1'
  spec.add_development_dependency 'rubocop', '~> 0.49.1'
end
