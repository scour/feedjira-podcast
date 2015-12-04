module Feedjira
  module Podcast
    module Channel
      class AppleSubcategory
        include SAXMachine
        include FeedUtilities

        attribute :text

        def valid?(category)
          AppleCategory::CATEGORIES[category.text].include?(text)
        end
      end
    end
  end
end
