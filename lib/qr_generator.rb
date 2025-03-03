require 'fileutils'
require 'jekyll_plugin_support'
require 'rqrcode'

class QRCodeGenerator < JekyllSupport::JekyllGenerator
  QR_PATH = 'assets/images/qrcodes'.freeze

  def generate_impl
    @logger.info { 'Loading QRCodeGenerator' }
    @qr_config = @config['qrcode']
    @fg_color  = @qr_config['fg_color'] || :black
    @bg_color  = @qr_config['bg_color']

    @domain = @config['domain']

    unless @domain
      @logger.error do
        <<~END_ERROR
          Error: _config.yml must have an entry for 'domain'. For example:
            domain: www.mslinn.com

          No QR codes will be generated until the problem is corrected.
        END_ERROR
      end
      return
    end

    FileUtils.mkdir_p QR_PATH
    @site.everything.each { |x| write_qrcode x }
  end

  def write_qrcode(apage)
    ext = apage.extname
    filepath_no_ext = URI(apage.url).path.delete_suffix ext
    filepath_no_ext += 'index' if filepath_no_ext.end_with? '/'
    filepath = "#{filepath_no_ext}.svg"
    static_file = Jekyll::StaticFile.new(@site, @site.source, QR_PATH, filepath)
    return if @site.static_files.include? static_file

    url = "https://#{@domain}#{apage.url}"
    @logger.debug { "Creating QR Code for #{url}" }
    qrcode = RQRCode::QRCode.new url

    rendered_svg = qrcode.as_svg(
      color:    @fg_color,
      fill:     @bg_color,
      size:     160,
      use_path: true,
      viewbox:  true
    )

    filename_fq = "#{@site.source}/#{QR_PATH}#{filepath}"
    @logger.debug { "Writing QR code to #{filename_fq}" }
    FileUtils.mkdir_p File.dirname filename_fq
    bytes_written = File.write(filename_fq, rendered_svg.to_s)
    @logger.debug { "#{bytes_written} bytes written to #{filename_fq}" }

    @site.static_files << static_file
  end
end
