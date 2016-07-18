# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'druzy/server/version'

Gem::Specification.new do |spec|
  spec.name          = "druzy-server"
  spec.version       = Druzy::Server::VERSION
  spec.authors       = ["Jonathan Le Greneur"]
  spec.email         = ["jonathan.legreneur@free.fr"]

  spec.summary       = %q{A very restrictive http server}
  spec.description   = %q{A very restrictive http server to send any file}
  spec.homepage      = "https://github.com/druzy/ruby-druzy-server"
  spec.license       = "MIT"

  spec.files         = `find lib -type f`.split("\n")
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'druzy-utils', '>= 1.0.0'
  spec.add_runtime_dependency 'i18n', '>= 0.7.0'

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
