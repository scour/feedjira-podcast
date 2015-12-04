module Feedjira
  module Podcast
    module Channel
      class Cloud
        include SAXMachine
        include FeedUtilities

        attribute :domain
        attribute :port
        attribute :path
        attribute :registerProcedure
        attribute :protocol
      end
    end
  end
end
