require 'pathname'

# Adds a `.qrcode` property to each Jekyll page and document
module Jekyll
  class QRPath
    def self.hook_proc
      proc { |page|
        site = page.site
        qr_dir = File.dirname "/assets/images/qrcodes#{Pathname.new(page.url).to_path}"
        basename = page.respond_to?(:basename_without_ext) ? page.basename_without_ext : page.basename
        qr_path = "https://#{site.config['domain']}#{qr_dir}/#{basename}.svg"
        puts "QRPath: #{qr_path}"
        page.data['qrcode'] = qr_path
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
