# keal

A keep alive program for Linux/GNOME, inspired by [caffeinate(8)](https://ss64.com/osx/caffeinate.html) on MacOS.

## Installation

You may install keal using `gem install keal`, however, this will not install the systemd unit file. So, for now, the recommended way to install `keal` is:

```sh
git clone https://github.com/pinecat/keal
cd keal
bin/setup
sudo rake install
sudo rake install:service
```

```sh
git clone https://github.com/pinecat/keal && cd keal && bin/setup && sudo rake install && sudo rake install:service # one-liner
```

### Non-RPM-based distros

Currently, `bin/setup` only supports RPM-based distros. I would like to add support for more distros in the near future, however, if you just want to try it out--on, say Ubuntu--you can run `bundle install`, and then you'll need to get the following from your package manager:

- glibmm2.4 headers
- ruby development headers
- make
- g++

## Usage

```sh
$ keal [options] [program [args]]
```

### Caveats

Right now, `keal` has two options that affect how it runs: `-i`, and `-l`. The `-i` option will disable screen idle (meaning the screen will never turn off it's display). In current versions of GNOME, this is also disable the lock-screen, as the screen will only ever lock after the display as gone blank. The `-l` option--which disables the screen from locking--may be specified alongside the `-i` option if you wish, however, it is redundant in that case.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pinecat/keal.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
