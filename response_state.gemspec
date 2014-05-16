# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'response_state/version'

Gem::Specification.new do |spec|
  spec.name          = 'response_state'
  spec.version       = ResponseState::VERSION
  spec.authors       = ['alexpeachey']
  spec.email         = ['alex.peachey@originate.com']
  spec.description   = 'Easy to use response state pattern'
  spec.summary       = 'Easy to use response state pattern'
  spec.homepage      = 'http://github.com/Originate/response_state'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
end
