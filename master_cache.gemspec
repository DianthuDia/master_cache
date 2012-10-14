# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'master_cache/version'

Gem::Specification.new do |gem|
  gem.name          = "master_cache"
  gem.version       = MasterCache::VERSION
  gem.authors       = ["DianthuDia"]
  gem.email         = ["dianthudia@y7mail.com"]
  gem.description   = "A master record cache plugin"
  gem.summary       = "master_cache provides 'master record' cache and easy access these"
  gem.homepage      = "https://github.com/DianthuDia/master_cache"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'activerecord', '>= 3.0.0'
  
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'sqlite3'
  gem.add_development_dependency 'guard'
  gem.add_development_dependency 'rb-fsevent' if RUBY_PLATFORM.include? 'darwin'
  gem.add_development_dependency 'rb-inotify' if RUBY_PLATFORM.include? 'linux'
  gem.add_development_dependency 'guard-bundler'
  gem.add_development_dependency 'guard-rspec'
end
