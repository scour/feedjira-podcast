module Feedjira
  module Podcast
    module Channel
      class SkipDays
        include SAXMachine
        include FeedUtilities

        elements :day, as: :day do |day|
          day.to_sym
        end

        def days
          @days ||= day ? day : []
        end
      end
    end
  end
end
