# RestclientCommunicator

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/restclient_communicator`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'restclient_communicator',:git => 'https://github.com/olafkaderka/restclient_communicator.git', :branch => 'master'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install restclient_communicator

## Usage

new_connect = RestclientCommunicator::Communication.new(url)

das object new_connect hat dann folgende attribute:
:errorcode, :response, :http_code, :body, :options

Es werden zahlreiche Fehler abgefangen und man kann das Verhalten auch ändern durch Optionen die man übergeben kann. 
Folgende Werte sind automatisch gesetzt:
:method => :get,
:open_timeout => 5,
:read_timeout => 5,
:max_redirects => 1,

new_connect = RestclientCommunicator::Communication.new(url, {:max_redirects => 0}) 
* bewirkt zb das bei einem 301,302, oder 307 nicht automatisch der neuen url gefolgt wird

new_connect = RestclientCommunicator::Communication.new(url, {:open_timeout => 1, :read_timeout => 30) 
* bewirkt zb das bereits nach 1 Sekunde das timeout erreicht ist zum öffnen der Verbindung, aber erst nach 30 Sekunden der response



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/restclient_communicator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RestclientCommunicator project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/restclient_communicator/blob/master/CODE_OF_CONDUCT.md).
