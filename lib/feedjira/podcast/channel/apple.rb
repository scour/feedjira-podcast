module Feedjira
  module Podcast
    module Channel
      module Apple
        def self.included(base)

          base.element :"itunes:author", as: :itunes_author

          base.element :"itunes:block", as: :itunes_block do |block|
            block == 'yes'
          end

          # base.element :"itunes:category", as: :itunes_author

          base.element :"itunes:image", as: :itunes_image_href, value: :href do |href|
            Addressable::URI.parse(href)
          end

          base.element :"itunes:explicit", as: :_itunes_explicit

          base.element :"itunes:complete", as: :itunes_complete do |complete|
            complete == 'yes'
          end

          base.element :"itunes:new_feed_url", as: :itunes_new_feed_url do |url|
            Addressable::URI.parse(url)
          end

          base.element :"itunes:owner", as: :_itunes_owner, class: AppleOwner
          base.element :"itunes:subtitle", as: :itunes_subtitle
          base.element :"itunes:summary", as: :itunes_summary

          def itunes
            @itunes ||= Struct.new(
              :author,
              :block?,
              # :category,
              :image,
              :explicit?,
              :clean?,
              :complete?,
              :new_feed_url,
              :owner,
              :subtitle,
              :summary,
            ).new(
              itunes_author,
              itunes_block,
              # itunes_category,
              itunes_image,
              itunes_explicit,
              itunes_clean,
              itunes_complete,
              itunes_new_feed_url,
              itunes_owner,
              itunes_subtitle,
              itunes_summary,
            )
          end

          private

          def itunes_image
            @itunes_image ||= Struct.new(:href).new(itunes_image_href)
          end

          def itunes_explicit
            @itunes_explicit ||= (_itunes_explicit == 'yes')
          end

          def itunes_clean
            @itunes_clean ||=  (_itunes_explicit == 'clean')
          end

          def itunes_owner
            @itunes_owner ||= Struct.new(:email, :name).new(
              _itunes_owner && _itunes_owner.email,
              _itunes_owner && _itunes_owner.name,
            )
          end

        end
      end
    end
  end
end
