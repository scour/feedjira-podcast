module Feedjira
  module Podcast
    module Item
      class Source
        include SAXMachine
        include FeedUtilities

        value :source, as: :name

        attribute :url do |url|
          Addressable::URI.parse(url)
        end

      end
    end
  end
end
