module Feedjira
  module Podcast
    module Channel
      module Syndication
        module InstanceMethods
        end

        def self.included(_base)
          base.include(InstanceMethods)
        end
      end
    end
  end
end
