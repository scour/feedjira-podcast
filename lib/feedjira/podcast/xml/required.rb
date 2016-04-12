module Feedjira
  module Podcast
    module XML
      module Required
        def self.included(base)
          base.element :rss, class: RSS
        end
      end
    end
  end
end
