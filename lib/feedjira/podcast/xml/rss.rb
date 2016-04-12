module Feedjira
  module Podcast
    module XML
      class RSS
        include SAXMachine
        include FeedUtilities

        include ::Feedjira::Podcast::RSS::Required
      end
    end
  end
end
