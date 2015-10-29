module Feedjira
  module Podcast
    module Item
      module Required
        def self.included(base)
          base.element :title
          base.element :description
        end
      end
    end
  end
end
