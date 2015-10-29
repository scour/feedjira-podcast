module Feedjira
  module Podcast
    module Item
      module Content
        module InstanceMethods
          def content
            @content ||= Struct.new(:encoded).new(content_encoded)
          end
        end

        def self.included(base)
          base.include(InstanceMethods)

          base.element :"content:encoded", as: :content_encoded
        end
      end
    end
  end
end
