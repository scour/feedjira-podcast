module Feedjira
  module Podcast
    module Item
      module Dublin
        module InstanceMethods
          def dc
            @dc ||= Struct.new(:creator).new(
              dc_creator,
            )
          end
        end

        def self.included(base)
          base.include(InstanceMethods)

          dc_xml_ns = "dc"

          base.element :"#{dc_xml_ns}:creator", as: :dc_creator
        end
      end
    end
  end
end
