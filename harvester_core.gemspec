# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'harvester_core/version'

Gem::Specification.new do |gem|
  gem.name          = "harvester_core"
  gem.version       = HarvesterCore::VERSION
  gem.authors       = ["Federico Gonzalez"]
  gem.email         = ["fedegl@gmail.com"]
  gem.description   = %q{DSL to scrape websites}
  gem.summary       = %q{DSL to scrape websites}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency "activemodel",     ">= 3.2"
  gem.add_runtime_dependency "activesupport",   ">= 3.2"
  gem.add_runtime_dependency "actionpack",      ">= 3.2"
  gem.add_runtime_dependency "redis",           "~> 3"

  gem.add_runtime_dependency "nokogiri"
  gem.add_runtime_dependency "rest-client",     "~> 1.6.7"
  gem.add_runtime_dependency "jsonpath",        "~> 0.5.0"
  gem.add_runtime_dependency "chronic",         "~> 0.8.0"
  gem.add_runtime_dependency "tzinfo"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec",      "~> 2.11.0"
  gem.add_development_dependency "webmock",    "~> 1.8"
end