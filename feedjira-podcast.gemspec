# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "feedjira/podcast/version"

Gem::Specification.new do |spec|
  spec.name          = "feedjira-podcast"
  spec.version       = Feedjira::Podcast::VERSION
  spec.authors       = ["Chris Kalafarski"]
  spec.email         = ["chris@farski.com"]

  spec.summary       = "Podcast feed parsing with Feedjira"
  spec.description   = "Podcast feed parsing with Feedjira"
  spec.homepage      = "https://github.com/scour/feedjira-podcast"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  end

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.5"
  spec.add_development_dependency "coveralls", "~> 0"
  spec.add_development_dependency "rubocop", "~> 0"

  spec.add_runtime_dependency "feedjira", "~> 2.0"
  spec.add_runtime_dependency "addressable", "~> 2.3"
end
