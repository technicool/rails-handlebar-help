# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'handlebar-help/version'

Gem::Specification.new do |gem|
  gem.name          = "handlebar-help"
  gem.version       = Handlebar::Help::VERSION
  gem.authors       = ["Marshall Anschutz"]
  gem.email         = ["timeis4d@gmail.com"]
  gem.description   = %q{Handlebars.js inline template helpers}
  gem.summary       = %q{Some helpers that work in both html and js erb files to generate handlebars templates inline.}
  gem.homepage      = "https://github.com/technicool/rails-handlebar-help"
  
  gem.add_development_dependency = "rspec"
  

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
