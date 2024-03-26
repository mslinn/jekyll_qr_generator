require 'rqrcode'

# Called after all source files have been read and loaded from disk.
# This is a good hook for enriching posts;
# for example, adding links to author pages or adding posts to author pages.
Jekyll::Hooks.register(:site, :post_read, priority: :normal) do |site|
  @log_site.info { 'Jekyll::Hooks.register(:site, :post_read) invoked.' }

  unless Dir.exist? '_site'
    puts 'Error: _site directory does not exist'
    exit 1
  end

  File.mkdirs '_site/assets/images/qrcodes'

  url_base = site.config['website']
  site.docs.each do |doc|
    write_qrcode url_base, doc
  end
end

def write_qrcode(url_base, doc)
  url = "#{url_base}/#{doc.url}"
  filename = doc.page
  qrcode = RQRCode::QRCode.new(url)
  qrcode.as_png(
    color: 0x114163FF,
    file:  "_site/assets/images/qrcodes/#{filename}.png"
  )
end
