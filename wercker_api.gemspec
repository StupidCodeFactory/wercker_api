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

  spec.add_dependency 'virtus'
  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-collection_matchers"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "gem-release"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "awesome_print"
end
