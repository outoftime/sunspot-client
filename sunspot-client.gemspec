require File.expand_path('../lib/sunspot/client/version', __FILE__)

Gem::Specification.new do |s|
  s.name = 'sunspot-client'
  s.version = Gem::Version.new(Sunspot::Client::VERSION)
  s.summary = 'Client library for searching Ruby objects with Solr'
  s.description = <<TEXT
Sunspot is a set of libraries that perform powerful abstraction for indexing and
search of persistent Ruby objects using Solr. Sunspot integrates with popular
Ruby ORMs and exposes powerful fulltext, faceting, geo-search, and other search
features, all maintaining a pure-Ruby API. The sunspot-client library exposes
Sunspot's runtime search and indexing functionality; it is recommended that this
library is used as a dependency directly in production environments, but that
the sunspot meta-gem is used in development, as it includes a bundled Solr
package that makes bootstrapping local search quick and easy.
TEXT
  s.add_runtime_dependency 'rsolr', '~> 1.0'
  s.add_runtime_dependency 'soolr', Sunspot::Client::VERSION
  s.add_runtime_dependency 'json_pure', '~> 1.5.1'

  s.add_development_dependency 'fakeweb'
  s.add_development_dependency 'rspec'
end
