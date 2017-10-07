# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "restclient_communicator/version"

Gem::Specification.new do |spec|
  spec.name          = "restclient_communicator"
  spec.version       = RestclientCommunicator::VERSION
  spec.authors       = ["Olaf Kaderka"]
  spec.email         = ["okaderka@yahoo.de"]

  spec.summary       = %q{Hilfsklasse für die Kommunikation ueber RestClient}
  spec.description   = %q{Gibt nicht viel mehr darüber zu erzaehlen}
  spec.homepage      = "https://github.com/olafkaderka/restclient_communicator"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"


  #communication
  #fuer sauber uris https://github.com/sporkmonger/addressable
  spec.add_dependency "addressable"

  #for mattr_accessor, reverse_merge
  spec.add_dependency "activesupport", '>= 4.0'

  #https://github.com/rest-client/rest-client
  spec.add_dependency "rest-client"

end
