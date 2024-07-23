require 'pathname'

# Adds a `.qrcode` property to each Jekyll page and document
module JekyllQRCodes
  class QRCodeEnrichmentData
    def initialize
      @logger = PluginMetaLogger.instance.new_logger(self, PluginMetaLogger.instance.config)
    end

    def page_qr_codes
      @logger.info { 'QRCodeEnrichmentData: Enriching Jekyll pages with QR code data' }
      enrich_with_qr_data
    end

    def document_qr_codes
      @logger.info { 'QRCodeEnrichmentData: Enriching Jekyll documents with QR code data' }
      enrich_with_qr_data
    end

    def enrich_with_qr_data
      proc { |page|
        qr_dir = "/assets/images/qrcodes#{File.dirname(Pathname.new(page.url).to_path).delete_suffix '/'}"
        basename = page.respond_to?(:basename_without_ext) ? page.basename_without_ext : page.basename
        qr_path = "#{qr_dir}/#{basename}.svg"
        @logger.debug do
          <<~END_OUTPUT

            page.url: #{page.url}
            qr_dir: #{qr_dir}
            basename: #{basename}
            qr_path: #{qr_path}
          END_OUTPUT
        end
        page.data['qrcode'] = qr_path
      }
    end
  end

  Jekyll::Hooks.register(:site, :after_reset, priority: :normal) do |_site|
    qced = QRCodeEnrichmentData.new
    ::Jekyll::Hooks.register :pages,     :post_init, &qced.page_qr_codes
    ::Jekyll::Hooks.register :documents, :post_init, &qced.document_qr_codes
  end
end
