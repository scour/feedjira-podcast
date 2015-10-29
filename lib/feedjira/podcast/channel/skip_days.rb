module Feedjira
  module Podcast
    module Channel
      class SkipDays
        include SAXMachine
        include FeedUtilities

        elements :day, as: :day, &:to_sym

        def days
          @days ||= day ? day : []
        end
      end
    end
  end
end
