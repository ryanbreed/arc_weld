# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'arc_weld/version'

Gem::Specification.new do |spec|
  spec.name          = 'arc_weld'
  spec.version       = ArcWeld::VERSION
  spec.authors       = ['Ryan Breed']
  spec.email         = ['opensource@breed.org']

  spec.summary       = 'Toolkit for building ArcSight resources'
  spec.description   = 'Toolkit for building ArcSight resources'
  spec.homepage      = 'https://github.com/ryanbreed/arc_weld'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'gyoku'
  spec.add_dependency 'nokogiri'
  spec.add_dependency 'thor'

  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-doc'
  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'guard-bundler'
  spec.add_development_dependency 'simplecov'
end
