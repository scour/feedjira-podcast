module Feedjira
  module Podcast
    module Item
      module Optional
        module InstanceMethods
          def categories
            category.map(&:strip).uniq
          end

          def enclosure
            @enclosure ||= Struct.new(:url, :length, :type).new(
              enclosure_url,
              enclosure_length,
              enclosure_type,
            )
          end
        end

        def self.included(base)
          base.include(InstanceMethods)

          base.element :link do |link|
            Addressable::URI.parse(link.strip)
          end

          base.element :author

          base.elements :category

          base.element :comments do |comments|
            Addressable::URI.parse(comments.strip)
          end

          base.element :enclosure, as: :enclosure_url, value: :url do |url|
            Addressable::URI.parse(url.strip)
          end

          base.element :enclosure, as: :enclosure_length, value: :length, &:to_f

          base.element :enclosure, as: :enclosure_type, value: :type

          base.element :guid, as: :guid, class: GUID, default: Struct.new(:guid, :perma_link?).new(nil, false)

          base.element :pubDate, as: :pub_date do |date|
            begin
              Time.parse(date)
            rescue
              nil
            end
          end

          base.element :source, class: Source, default: Struct.new(:name, :url).new
        end
      end
    end
  end
end
