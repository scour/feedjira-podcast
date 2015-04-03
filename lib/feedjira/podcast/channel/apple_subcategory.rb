module Feedjira
  module Podcast
    module Channel
      class AppleSubcategory
        include SAXMachine
        include FeedUtilities

        attribute :text

      end
    end
  end
end
