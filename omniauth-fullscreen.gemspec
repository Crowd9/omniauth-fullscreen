# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth/fullscreen/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Sean Stavropoulos"]
  gem.email         = ["seans@fullscreen.net"]
  gem.description   = %q{The Official Fullscreen OAuth2 strategy}
  gem.summary       = %q{A Official Fullscreen OAuth2 strategy}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "omniauth-fullscreen"
  gem.require_paths = ["lib"]
  gem.version       = OmniAuth::Fullscreen::VERSION

  gem.add_runtime_dependency 'omniauth-oauth2'

  gem.add_development_dependency 'rspec', '~> 2.6.0'
  gem.add_development_dependency 'rake'
end