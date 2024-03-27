require 'fileutils'
require 'jekyll_all_collections'
require 'jekyll_plugin_logger'
require 'rqrcode'

class Generator < Jekyll::Generator
  QR_PATH = 'assets/images/qrcodes'.freeze

  def generate(site)
    @logger ||= PluginMetaLogger.instance.new_logger(:SiteHooks, PluginMetaLogger.instance.config)
    @logger.info { 'Jekyll::Hooks.register(:documents, :pre_render) invoked.' }
    @site = site
    @domain = site.config['domain']

    unless @domain
      @logger.error do
        <<~END_ERROR
          Error: _config.yml must have an entry for domain. For example:
            domain: www.my_domain.com
        END_ERROR
      end
      exit 2
    end

    FileUtils.mkdir_p QR_PATH
    items = (@site.all_collections + @site.pages)
    items.each { |x| write_qrcode x }
  end

  def write_qrcode(apage)
    ext = apage.extname
    filepath_no_ext = URI(apage.url).path.delete_suffix ext
    filepath_no_ext += 'index' if filepath_no_ext.end_with? '/'
    filepath = "#{filepath_no_ext}.svg"
    static_file = Jekyll::StaticFile.new(@site, @site.source, QR_PATH, filepath)
    return if @site.static_files.include? static_file

    url = "https://#{@domain}#{apage.url}"
    @logger.info { "Creating QR Code for #{url}" }
    qrcode = RQRCode::QRCode.new url

    rendered_svg = qrcode.as_svg(
      color:    :yellow,
      size:     160,
      use_path: true,
      viewbox:  true
    )

    filename_fq = "#{@site.source}/#{QR_PATH}#{filepath}"
    @logger.info { "Writing QR code to #{filename_fq}" }
    FileUtils.mkdir_p File.dirname filename_fq
    bytes_written = File.write(filename_fq, rendered_svg.to_s)
    @logger.info { "#{bytes_written} bytes written to #{filename_fq}" }

    @site.static_files << static_file
  end
end
