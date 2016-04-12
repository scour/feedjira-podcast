module Feedjira
  module Podcast
    module RSS
      module Required
        def self.included(base)
          base.element :channel, class: Channel
          base.attribute :version

          base.ancestor :xml
        end
      end
    end
  end
end
