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

This Jekyll plugin creates an SVG image for every web page on the Jekyll website,
in the `/assets/images/qrcodes/` directory.

The SVG will have the same name as the web page that it is made for,
with an `.svg` file type instead of an `.html` file type, and the QR code path starts with `/assets/images/qrcodes`.

For example, the Jekyll page at `/blog/2024/03/25/2022-05-01-test2.html` will use the image at `/assets/images/qrcodes/blog/2024/03/25/2022-05-01-test2.svg`.

The plugin adds the path to the relevant SVG image in a data attribute called `qrcode` to each Jekyll page and document.

Place the QR code on each page by adding the following to a template:

```html
<img
  alt="Share this page by using this QR code"
  class="qrcode"
  src="{{page['qrcode']}}"
  title="Share this page by using this QR code"
>
```

The `demo` Jekyll site in this git repository defines the `qrcode` CSS class in a file called `demo/assets/css/qrcode.css`:

```css
.qrcode {
  float: left;
  padding: 0.4rem;
  width: auto;
  height: 100%;
}
```


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
