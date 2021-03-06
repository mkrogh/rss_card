# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rss_card/version'

Gem::Specification.new do |gem|
  gem.name          = "rss_card"
  gem.version       = RssCard::VERSION
  gem.authors       = ["Markus Krogh"]
  gem.email         = ["markus@casadelkrogh.dk"]
  gem.description   = "Simple rss feed fetching and rss cards"
  gem.summary       = ""
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features|spikes)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rspec", "~>2.14"
end
