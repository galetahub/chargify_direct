# encoding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chargify_direct/version'

Gem::Specification.new do |s|
  s.name          = 'chargify_direct'
  s.version       = ChargifyDirect::VERSION.dup
  s.platform      = Gem::Platform::RUBY
  s.summary       = 'Chargify Direct API (v2) client'
  s.description   = 'Chargify Direct API (v2) client, based on faraday'
  s.author        = 'Aleksandr Schigol'
  s.email         = 'aleksandr@schigol.com'
  s.homepage      = 'https://github.com/4oZ/chargify_direct'
  s.license       = 'MIT'

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_runtime_dependency 'faraday', '0.9.0.rc6'
  s.add_runtime_dependency 'multi_json'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'vcr'
end
