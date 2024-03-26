require_relative 'lib/jekyll_qr_generator/version'

Gem::Specification.new do |spec|
  host = 'https://github.com/mslinn/jekyll_qr_generator'

  spec.authors               = ['Mike Slinn']
  spec.description           = <<~END_DESC
    Jekyll generator that makes a QR code for every url in the website.
  END_DESC
  spec.email                 = ['mslinn@mslinn.com']
  spec.files                 = Dir['.rubocop.yml', 'LICENSE.*', 'Rakefile', '{lib,spec}/**/*', '*.gemspec', '*.md']
  spec.homepage              = 'https://github.com/mslinn/jekyll_qr_generator'
  spec.license               = 'MIT'
  spec.metadata = {
    'allowed_push_host' => 'https://rubygems.org',
    'bug_tracker_uri'   => "#{host}/issues",
    'changelog_uri'     => "#{host}/CHANGELOG.md",
    'homepage_uri'      => spec.homepage,
    'source_code_uri'   => host,
  }
  spec.name                 = 'jekyll_qr_generator'
  spec.post_install_message = <<~END_MESSAGE

    Thanks for installing #{spec.name}!

  END_MESSAGE
  spec.require_paths         = ['lib']
  spec.required_ruby_version = '>= 3.0.0'
  spec.summary               = 'Jekyll generator that makes a QR code for every url in the website.'
  spec.version               = JekyllQrGenerator::VERSION

  spec.add_dependency 'jekyll'
  spec.add_dependency 'jekyll_all_collections'
  spec.add_dependency 'jekyll_plugin_logger'
  spec.add_dependency 'rqrcode'
end
