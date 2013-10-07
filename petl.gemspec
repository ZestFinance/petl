# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'petl/version'

Gem::Specification.new do |spec|
  spec.name          = "petl"
  spec.version       = Petl::VERSION
  spec.authors       = ["Alexander Tamoykin", "Chris Rosario"]
  spec.email         = ["at@zestfinance.com", "car@zestfinance.com"]
  spec.description   = %q{Pretty good ETL framework}
  spec.summary       = %q{Pretty good ETL framework}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
