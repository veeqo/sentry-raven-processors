# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'raven_processors/version'

Gem::Specification.new do |spec|
  spec.name          = 'sentry-raven-processors'
  spec.version       = RavenProcessors::VERSION
  spec.authors       = ['Rustam Sharshenov']
  spec.email         = ['rustam@sharshenov.com']

  spec.summary       = 'Additional processors for Sentry Raven'
  spec.description   = 'Additional processors for Sentry Raven'
  spec.homepage      = 'https://github.com/veeqo/sentry-raven-processors'
  spec.license       = 'MIT'

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'sentry-raven'

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
