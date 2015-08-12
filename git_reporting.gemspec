# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'git_reporting/version'

Gem::Specification.new do |spec|
  spec.name          = "git_reporting"
  spec.version       = GitReporting::VERSION
  spec.authors       = ["bsboris"]
  spec.email         = ["bsboris@gmail.com"]

  spec.summary       = %q{Git reporitng.}
  spec.description   = %q{Git reporitng.}
  spec.homepage      = "https://github.com/bsboris/git_reporting"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", "~> 4.2"
  spec.add_dependency "chronic_duration", "~> 0.10"
  spec.add_dependency "octokit", "~> 4.0"

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "faker", "~> 1.4"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "vcr", "~> 2.9.3"
  spec.add_development_dependency "webmock", "~> 1.21"
end
