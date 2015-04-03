module Feedjira
  module Podcast
    module Channel
      class Image
        include SAXMachine
        include FeedUtilities

        element :url do |url|
          Addressable::URI.parse(url)
        end

        element :title

        element :link do |link|
          Addressable::URI.parse(link)
        end

        element :width do |width|
          width.to_f
        end

        element :height do |height|
          height.to_f
        end

        element :description
      end
    end
  end
end
