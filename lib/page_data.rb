require 'pathname'

# Adds a `.qrcode` property to each Jekyll page and document
module Jekyll
  class QRPath
    def self.hook_proc
      proc { |page|
        qr_dir = File.dirname "/assets/images/qrcodes#{Pathname.new(page.url).to_path}"
        basename = page.respond_to?(:basename_without_ext) ? page.basename_without_ext : page.basename
        filepath = "#{qr_dir}/#{basename}.svg"
        puts "QRPath: #{filepath}"
        page.data['qrcode'] = filepath
      }
    end

    def initialize(filename)
      raise 'Error: empty filename' if filename.empty?

      @filename = filename
    end

    def to_liquid
      @filename
    end
  end

  Hooks.register :pages,     :post_init, &QRPath.hook_proc
  Hooks.register :documents, :post_init, &QRPath.hook_proc
end
