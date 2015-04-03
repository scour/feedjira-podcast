module Feedjira
  module Podcast
    module Item
      module Content
        def self.included(base)

          base.element :"content:encoded", as: :content_encoded

          def content
            @content ||= Struct.new(:encoded).new(content_encoded)
          end

        end
      end
    end
  end
end
