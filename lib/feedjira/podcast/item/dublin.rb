module Feedjira
  module Podcast
    module Item
      module Dublin
        def self.included(base)

          base.element :"dc:creator", as: :dc_creator

          def dc
            @dc ||= Struct.new(:creator).new(
              dc_creator,
            )
          end

        end
      end
    end
  end
end
