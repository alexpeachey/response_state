# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'responsive_service/version'

Gem::Specification.new do |spec|
  spec.name          = 'responsive_service'
  spec.version       = ResponsiveService::VERSION
  spec.authors       = ['alexpeachey']
  spec.email         = ['alex.peachey@gmail.com']
  spec.description   = 'Easy to use responsive service pattern'
  spec.summary       = 'Easy to use responsive service pattern'
  spec.homepage      = 'http://github.com/alexpeachey/responsive_service'
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
