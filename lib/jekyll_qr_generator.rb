require_relative 'jekyll_qr_generator/version'

# Require all Ruby files in 'lib/', except this file
Dir[File.join(__dir__, '*.rb')].each do |file|
  require file unless file.end_with?('/jekyll_qr_generator.rb')
end
