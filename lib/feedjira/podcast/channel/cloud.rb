module Feedjira
  module Podcast
    module Channel
      class Cloud
        include SAXMachine
        include FeedUtilities

        attribute :domain
        attribute :port
        attribute :path
        attribute :registerProcedure, as: :register_procedure
        attribute :protocol
      end
    end
  end
end
