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

        element :width, &:to_f
        element :height, &:to_f
        element :description
      end
    end
  end
end
