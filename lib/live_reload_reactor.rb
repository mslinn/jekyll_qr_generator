module Jekyll
  module Commands
    class Serve < Command
      class << self
        private

        def register_reload_hooks(opts)
          require_relative 'serve/live_reload_reactor'
          @reload_reactor = LiveReloadReactor.new

          Jekyll::Hooks.register(:site, :post_render) do |site|
            @changed_pages = []
            site.each_site_file do |item| # Examine each Page, StaticFile and Document
              @changed_pages << item if site.regenerator.regenerate?(item)
            end
          end

          # A note on ignoring files: LiveReload errs on the side of reloading when it
          # comes to the message it gets.  If, for example, a page is ignored but a CSS
          # file linked in the page isn't, the page will still be reloaded if the CSS
          # file is contained in the message sent to LiveReload.  Additionally, the
          # path matching is very loose so that a message to reload "/" will always
          # lead the page to reload since every relative path page is supposed starts with "/".
          # Unfortunately, many of the paths are duplicated, with and without the leading "/".
          Jekyll::Hooks.register(:site, :post_write) do
            if @changed_pages && @reload_reactor && @reload_reactor.running?
              ignored_pages, @changed_pages = @changed_pages.partition do |p|
                opts['livereload_ignore'].any? do |filter|
                  File.fnmatch(filter, p.relative_path)
                end
              end
              Jekyll.logger.debug 'LiveReload:', "Ignoring #{ignored_pages.map(&:relative_path)}"
              puts 'Ignore: ' + ignored_pages.map(&:relative_path) # rubocop:disable Style/StringConcatenation
              puts 'Reload: ' + @changed_pages.map(&:relative_path) # rubocop:disable Style/StringConcatenation
              @reload_reactor.reload(@changed_pages)
            end
            @changed_pages = nil
          end
        end
      end
    end
  end
end
