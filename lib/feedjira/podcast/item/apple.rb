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
            @itunes_explicit ||= ["yes", "explicit", "true"].include?(_itunes_explicit)
          end

          def itunes_clean
            @itunes_clean ||= ["no", "clean", "false"].include?(_itunes_explicit)
          end
        end

        def self.included(base)
          base.include(InstanceMethods)

          itunes_xml_ns = "itunes"

          base.element :"#{itunes_xml_ns}:author", as: :itunes_author
          base.element :"#{itunes_xml_ns}:block", as: :_itunes_block

          base.element :"#{itunes_xml_ns}:image", as: :itunes_image_href, value: :href do |href|
            Addressable::URI.parse(href.strip)
          end

          base.element :"#{itunes_xml_ns}:duration", as: :itunes_duration do |d|
            ["0:0:0:#{d}".split(":")[-3, 3].map(&:to_i)].inject(0) do |_m, i|
              (i[0] * 3600) + (i[1] * 60) + i[2]
            end
          end

          base.element :"#{itunes_xml_ns}:explicit", as: :_itunes_explicit

          base.element :"#{itunes_xml_ns}:isClosedCaptioned", as: :_itunes_is_closed_captioned

          base.element :"#{itunes_xml_ns}:order", as: :itunes_order, &:to_f

          base.element :"#{itunes_xml_ns}:subtitle", as: :itunes_subtitle
          base.element :"#{itunes_xml_ns}:summary", as: :itunes_summary

          # Legacy support

          base.element :"#{itunes_xml_ns}:keywords", as: :itunes_keywords do |keywords|
            keywords.split(",").map(&:strip).select { |k| !k.empty? }
          end
        end
      end
    end
  end
end
