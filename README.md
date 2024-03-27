# `Jekyll_qr_generator` [![Gem Version](https://badge.fury.io/rb/jekyll_qr_generator.svg)](https://badge.fury.io/rb/jekyll_qr_generator)

`Jekyll_qr_generator` is a Jekyll generator plugin that can display a QR code for every web page in a Jekyll website.


## Installation

Add the following to your Jekyll website&rsquo;s `Gemfile`:

```ruby
group :jekyll_plugins do
  gem 'jekyll_qr_generator'
end
```

And then execute:

```shell
$ bundle
```


## Usage

This Jekyll plugin creates an SVG image for every web page on the Jekyll website,
in the `/assets/images/qrcodes/` directory.

Within the `/assets/images/qrcodes` directory, the generated SVG files will have the same file path as the web page that
they were made for, with an `.svg` file type instead of an `.html` file type.

For example, the Jekyll page at `/blog/2024/03/25/2022-05-01-test2.html` will use the image at
`/assets/images/qrcodes/blog/2024/03/25/2022-05-01-test2.svg`.

The plugin adds the path to the relevant SVG image in a data attribute called `qrcode` to each Jekyll page and document.
A Jekyll page or template can retrieve the path from the data attribute by using this incantation:
`{{page['qrcode']}}`.


### Jekyll Template

Place the QR code on each page by adding the following to a template.
The only attribute which must be used exactly as shown is `src`.

```html
<img
  alt="Share this page by using this QR code"
  class="qrcode"
  src="{{page['qrcode']}}"
  title="Share this page by using this QR code"
>
```


### CSS

The [`demo`](https://github.com/mslinn/jekyll_qr_generator/blob/master/demo/)
Jekyll site in this git repository defines the `qrcode` CSS class used the above HTML
in a file called [`demo/assets/css/qrcode.css`](https://github.com/mslinn/jekyll_qr_generator/blob/master/demo/assets/css/qrcode.css):

```css
.qrcode {
  float: left;
  padding: 0.4rem;
  width: auto;
  height: 100%;
}
```


### Configuration

By default, the QR code will have a black foreground over a transparent background.
You can change these defaults by adding an entry to
[`_config.yml`](https://github.com/mslinn/jekyll_qr_generator/blob/master/demo/_config.yml).

Adding the `qrcode` configuration entry controls `fg_color` and `bg_color`.
Following are some examples.

Yellow on a dark green background:

```yaml
qrcode:
  fg_color: yellow
  bg_color: darkgreen
```

Grey on a transparent background:

```yaml
qrcode:
  fg_color: '#666'
```

Black on a white background:

```yaml
qrcode:
  bg_color: white
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
