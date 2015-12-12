module Feedjira
  module Podcast
    module Item
      module Apple
        module InstanceMethods
          def itunes
            @itunes ||= Struct.new(
              :author,
              :block?,
              :image,
              :duration,
              :explicit?,
              :clean?,
              :closed_captioned?,
              :order,
              :subtitle,
              :summary,
              :keywords,
            ).new(
              itunes_author,
              itunes_block,
              itunes_image,
              itunes_duration,
              itunes_explicit,
              itunes_clean,
              itunes_is_closed_captioned,
              itunes_order,
              itunes_subtitle,
              itunes_summary,
              itunes_keywords,
            )
          end

          private

          def itunes_image
            @itunes_image ||= Struct.new(:href).new(itunes_image_href)
          end

          def itunes_block
            @itunes_block ||= (_itunes_block == "yes")
          end

          def itunes_is_closed_captioned
            @itunes_is_closed_captioned ||= (_itunes_is_closed_captioned == "yes")
          end

          def itunes_explicit
            @itunes_explicit ||= (_itunes_explicit == "yes")
          end

          def itunes_clean
            @itunes_clean ||= (_itunes_explicit == "clean")
          end
        end

        def self.included(base)
          base.include(InstanceMethods)

          base.element :"itunes:author", as: :itunes_author
          base.element :"itunes:block", as: :_itunes_block

          base.element :"itunes:image", as: :itunes_image_href, value: :href do |href|
            Addressable::URI.parse(href.strip)
          end

          base.element :"itunes:duration", as: :itunes_duration do |d|
            ["0:0:0:#{d}".split(":")[-3, 3].map(&:to_i)].inject(0) do |_m, i|
              (i[0] * 3600) + (i[1] * 60) + i[2]
            end
          end

          base.element :"itunes:explicit", as: :_itunes_explicit

          base.element :"itunes:isClosedCaptioned", as: :_itunes_is_closed_captioned

          base.element :"itunes:order", as: :itunes_order, &:to_f

          base.element :"itunes:subtitle", as: :itunes_subtitle
          base.element :"itunes:summary", as: :itunes_summary

          # Legacy support

          base.element :"itunes:keywords", as: :itunes_keywords do |keywords|
            keywords.split(",").map(&:strip).select { |k| !k.empty? }
          end
        end
      end
    end
  end
end
