module Feedjira
  module Podcast
    module Channel
      class SkipHours
        include SAXMachine
        include FeedUtilities

        elements :hour, as: :hour do |hour|
          hour.to_f
        end

        def hours
          @hours ||= hour ? hour : []
        end
      end
    end
  end
end
