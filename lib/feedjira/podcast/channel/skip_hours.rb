module Feedjira
  module Podcast
    module Channel
      class SkipHours
        include SAXMachine
        include FeedUtilities

        elements :hour, as: :hour, &:to_f

        def hours
          @hours ||= hour ? hour : []
        end
      end
    end
  end
end
