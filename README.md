# Druzy::Server

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'druzy-server'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install druzy-server

Or for ubuntu run:

    $ sudo add-apt-repository ppa:druzy_druzy/rubymita
    $ sudo apt-get update
    $ sudo apt-get install ruby-druzy-server

## Usage

There is one server by port. Get the server of the port with RestrictedFileServer.instance(port).
The server start when a file is autorized with RestrictedFileServer#add_file(file).
Get the address of the file with RestrictedFileServer#get_address(file).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/druzy/druzy-server.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

