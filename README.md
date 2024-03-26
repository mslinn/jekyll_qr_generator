# `Jekyll_qr_generator` [![Gem Version](https://badge.fury.io/rb/jekyll_qr_generator.svg)](https://badge.fury.io/rb/jekyll_qr_generator)

Jekyll generator that makes a QR code for every url in the website.


## Installation

Add this line to your Jekyll website&rsquo;s `Gemfile`:

```ruby
gem 'jekyll_qr_generator'
```

And then execute:

```shell
$ bundle
```


## Usage

Run Jekyll as usual.
A PNG will be created for every page on the Jekyll website,
in the `/assets/images/qrcodes/` directory.

The PNG will have the same name as the webpage that it is made for,
with a `.png` file type instead of an `.html` file type.


## Development

After checking out this git repository, install dependencies by typing:

```shell
$ bin/setup
```

You should do the above before running Visual Studio Code.


### Run the Tests

```shell
$ bundle exec rake test
```


### Interactive Session

The following will allow you to experiment:

```shell
$ bin/console
```


### Local Installation

To install this gem onto your local machine, type:

```shell
$ bundle exec rake install
```


### To Release A New Version

To create a git tag for the new version, push git commits and tags,
and push the new version of the gem to https://rubygems.org, type:

```shell
$ bundle exec rake release
```


## Contributing

Bug reports and pull requests are welcome at https://github.com/mslinn/jekyll_qr_generator.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
