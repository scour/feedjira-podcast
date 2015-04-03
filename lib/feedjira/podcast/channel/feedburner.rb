module Feedjira
  module Podcast
    module Channel
      module Feedburner
        def self.included(base)

          base.element :"feedburner:info", as: :feedburner_info_uri, value: :uri do |uri|
            Addressable::URI.parse(uri)
          end

          def feedburner
            info = Struct.new(:uri).new(feedburner_info_uri)
            @feedburner ||= Struct.new(:info).new(info)
          end

        end
      end
    end
  end
end
