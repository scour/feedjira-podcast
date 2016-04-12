module Feedjira
  module Podcast
    module Channel
      module Feedburner
        module InstanceMethods
          def feedburner
            info = Struct.new(:uri).new(feedburner_info_uri)
            @feedburner ||= Struct.new(:info).new(info)
          end
        end

        def self.included(base)
          base.include(InstanceMethods)

          feedburner_xml_ns = "feedburner"

          base.element :"#{feedburner_xml_ns}:info", as: :feedburner_info_uri, value: :uri do |uri|
            Addressable::URI.parse(uri.strip)
          end
        end
      end
    end
  end
end
