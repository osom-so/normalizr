# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'osom-normalizr/version'

Gem::Specification.new do |gem|
  gem.name          = "osom-normalizr"
  gem.version       = Osom::Normalizr::VERSION
  gem.authors       = ["Rafael Soto"]
  gem.email         = ["rafael@osom.so"]
  gem.description   = %q{osom normalizr}
  gem.summary       = %q{osom normalizr}
  gem.homepage      = ""

  gem.files         = Dir["{lib,vendor}/**/*"] + ["LICENSE.txt", "README.md"]
  gem.require_paths = ["lib"]
end
