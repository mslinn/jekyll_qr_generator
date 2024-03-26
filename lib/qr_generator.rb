require 'fileutils'
require 'jekyll_plugin_logger'
require 'rqrcode'

class Generator < Jekyll::Generator
  def generate(site)
    @log_site ||= PluginMetaLogger.instance.new_logger(:SiteHooks, PluginMetaLogger.instance.config)
    @log_site.info { 'Jekyll::Hooks.register(:documents, :pre_render) invoked.' }
    @site = site
    @qr_path = 'assets/images/qrcodes'
    @url_base = @site.config['domain']
    FileUtils.mkdir_p @qr_path, verbose: true

    @site.documents.each do |doc|
      write_qrcode doc
    end
    @site.pages.each do |page|
      write_qrcode page
    end
  end

  def write_qrcode(doc)
    filename = File.basename doc.path, doc.extname
    filename_fq = "#{@qr_path}/#{filename}.svg"

    url = "#{@url_base}#{doc.url}"
    puts "Writing QR code for #{url} to #{filename_fq}"
    qrcode = RQRCode::QRCode.new(url)

    rendered_svg = qrcode.as_svg(
      color:    :white,
      size:     160,
      use_path: true,
      viewbox:  true
    )
    bytes_written = File.write(filename_fq, rendered_svg.to_s)
    puts "#{bytes_written} bytes written"

    static_file = Jekyll::StaticFile.new(@site, @site.source, @qr_path, "#{filename}.svg")
    @site.static_files << static_file
  end
end
