module Feedjira
  module Podcast
    module Channel
      class TextInput
        include SAXMachine
        include FeedUtilities

        element :title
        element :description
        element :name

        element :link do |link|
          Addressable::URI.parse(link)
        end
      end
    end
  end
end
