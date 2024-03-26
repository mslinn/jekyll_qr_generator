require 'fileutils'
require 'jekyll_all_collections'
require 'jekyll_plugin_logger'
require 'rqrcode'

class Generator < Jekyll::Generator
  def generate(site)
    @log_site ||= PluginMetaLogger.instance.new_logger(:SiteHooks, PluginMetaLogger.instance.config)
    @log_site.info { 'Jekyll::Hooks.register(:documents, :pre_render) invoked.' }
    @site = site
    @qr_path = 'assets/images/qrcodes'
    @url_base = @site.config['domain']
    FileUtils.mkdir_p @qr_path
    items = (@site.all_collections + @site.pages)
    items.each { |x| write_qrcode x }
  end

  def write_qrcode(apage)
    ext = if apage.respond_to? :ext
            apage.ext
          elsif apage.respond_to? :extname
            apage.extname
          end
    filepath_no_ext = apage.url.delete_suffix ext
    filepath = "#{filepath_no_ext}.svg"
    filename_fq = "#{@site.source}/#{@qr_path}#{filepath}"

    url = "#{@url_base}#{apage.url}"
    # puts "Writing QR code for #{url} to #{filename_fq}"
    qrcode = RQRCode::QRCode.new(url)

    rendered_svg = qrcode.as_svg(
      color:    :white,
      size:     160,
      use_path: true,
      viewbox:  true
    )
    FileUtils.mkdir_p File.dirname filename_fq
    bytes_written = File.write(filename_fq, rendered_svg.to_s)
    puts "#{bytes_written} bytes written to #{filename_fq}"

    static_file = Jekyll::StaticFile.new(@site, @site.source, @qr_path, filepath)
    @site.static_files << static_file
  end
end
