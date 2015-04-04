module Feedjira
  module Podcast
    module Item
      module Optional
        def self.included(base)

          base.element :link do |link|
            Addressable::URI.parse(link)
          end

          base.element :author

          base.elements :category

          base.element :comments do |comments|
            Addressable::URI.parse(comments)
          end

          def categories
            category.map{|c|c.strip}.uniq
          end

          base.element :enclosure, as: :enclosure_url, value: :url do |url|
            Addressable::URI.parse(url)
          end

          base.element :enclosure, as: :enclosure_length, value: :length do |length|
            length.to_f
          end

          base.element :enclosure, as: :enclosure_type, value: :type

          def enclosure
            @enclosure ||= Struct.new(:url, :length, :type).new(
              enclosure_url,
              enclosure_length,
              enclosure_type,
            )
          end

          base.element :guid, as: :guid, class: GUID, default: Struct.new(:guid, :perma_link?).new

          base.element :pubDate, as: :pub_date do |date|
            begin
              Time.parse(date)
            rescue
              nil
            end
          end

          base.element :source do |source|
            Addressable::URI.parse(source)
          end

        end
      end
    end
  end
end
