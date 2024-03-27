require 'pathname'

# Adds a `.qrcode` property to each Jekyll page and document
module Jekyll
  class QRPath
    def self.hook_proc
      proc { |page|
        qr_dir = "/assets/images/qrcodes#{File.dirname(Pathname.new(page.url).to_path)}"
        basename = page.respond_to?(:basename_without_ext) ? page.basename_without_ext : page.basename
        qr_path = "#{qr_dir}/#{basename}.svg"
        # puts "\npage.url: #{page.url}"
        # puts "qr_dir: #{qr_dir}"
        # puts "basename: #{basename}"
        # puts "qr_path: #{qr_path}"
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
