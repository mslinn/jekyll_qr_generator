require 'rqrcode'

# Called after all source files have been read and loaded from disk.
# This is a good hook for enriching posts;
# for example, adding links to author pages or adding posts to author pages.
Jekyll::Hooks.register(:site, :post_read, priority: :normal) do |site|
  @log_site.info { 'Jekyll::Hooks.register(:site, :post_read) invoked.' }
  GenerateQRCodes.new(site).generate
end

class GenerateQRCodes
  def initialize(site)
    @site = site
    @qr_path = "#{@site.config.destination}/assets/images/qrcodes"
    @url_base = @site.config['domain']

    unless Dir.exist? site.config.destination
      puts "QR Generator error: directory '#{site.config.destination}' does not exist."
      exit 1
    end

    return if @url_base

    puts "QR Generator error: site.config does not contain a key called 'domain'."
    exit 1
  end

  def generate
    File.mkdir_p @qr_path

    @site.docs.each do |doc|
      write_qrcode @url_base, doc
    end
    @site.pages.each do |page|
      write_qrcode @url_base, page
    end
  end

  def write_qrcode(doc)
    filename = doc.page

    url = "#{@url_base}/#{doc.url}"
    qrcode = RQRCode::QRCode.new(url)

    qrcode.as_png(
      color: 0x114163FF,
      file:  "@qr_path/#{filename}.png"
    )
  end
end
