module Feedjira
  module Podcast
    module Channel
      class AppleOwner
        include SAXMachine
        include FeedUtilities

        element :"itunes:email", as: :email
        element :"itunes:name", as: :name
      end
    end
  end
end
