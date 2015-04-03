module Feedjira
  module Podcast
    module Channel
      class AppleCategory
        include SAXMachine
        include FeedUtilities

        attribute :text

        # element :"itunes:category", as: :subcategory, class: AppleSubcategory

      end
    end
  end
end
