# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "omniauth-coinbase/version"

Gem::Specification.new do |s|
  s.name        = "omniauth-coinbase"
  s.version     = OmniAuth::Coinbase::VERSION
  s.authors     = ["Miguel Palhas"]
  s.email       = ["mpalhas@gmail.com"]
  s.homepage    = "https://github.com/naps62/omniauth-coinbase"
  s.summary     = %q{OmniAuth strategy for Coinbase}
  s.description = %q{OmniAuth strategy for Coinbase}
  s.licenses    = ['MIT']

  s.rubyforge_project = "omniauth-coinbase"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'multi_json', '~> 1.3'
  s.add_runtime_dependency 'omniauth-oauth2', '~> 1.2'
  s.add_runtime_dependency 'coinbase', '~> 2.0'
  s.add_development_dependency 'rspec', '~> 2.7'
  s.add_development_dependency 'rack-test', '~> 0.6'
  s.add_development_dependency 'simplecov', '~> 0.10'
  s.add_development_dependency 'webmock', '~> 1.20'
end
