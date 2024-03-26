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

    unless @domain
      puts <<~END_ERROR
        Error: _config.yml must have an entry for domain. For example:
          domain: www.my_domain.com
      END_ERROR
      exit 2
    end

    FileUtils.mkdir_p @qr_path
    items = (@site.all_collections + @site.pages)
    items.each { |x| write_qrcode x }
  end

  def write_qrcode(apage)
    ext = apage.extname
    filepath_no_ext = URI(apage.url).path.delete_suffix ext
    filepath_no_ext += 'index' if filepath_no_ext.end_with? '/'
    filepath = "#{filepath_no_ext}.svg"
    static_file = Jekyll::StaticFile.new(@site, @site.source, @qr_path, filepath)
    return if @site.static_files.include? static_file

    url = "https://#{@url_base}#{apage.url}"
    puts "Creating QR Code for #{url}"
    qrcode = RQRCode::QRCode.new url

    rendered_svg = qrcode.as_svg(
      color:    :yellow,
      size:     160,
      use_path: true,
      viewbox:  true
    )

    filename_fq = "#{@site.source}/#{@qr_path}#{filepath}"
    puts "Writing QR code to #{filename_fq}"
    FileUtils.mkdir_p File.dirname filename_fq
    _bytes_written = File.write(filename_fq, rendered_svg.to_s)
    # puts "#{_bytes_written} bytes written to #{filename_fq}"

    puts "Marking #{static_file} for preservation"
    @site.static_files << static_file
  end
end
