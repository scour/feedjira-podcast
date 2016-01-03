module Feedjira
  module Podcast
    module Channel
      module Optional
        module InstanceMethods
          def categories
            category.map(&:strip).uniq
          end

          def cloud
            @cloud ||= cloud_struct.new(*cloud_params)
          end

          def image
            @image ||= image_struct.new(*image_params)
          end

          def skip
            @skip ||= skip_struct.new(*skip_params)
          end

          private

          def cloud_struct
            Struct.new(:domain, :port, :path, :register_procedure, :protocol)
          end

          def cloud_params
            return [] unless _cloud

            [
              _cloud.domain,
              _cloud.port,
              _cloud.path,
              _cloud.register_procedure,
              _cloud.protocol
            ]
          end

          def image_struct
            Struct.new(:url, :title, :link, :width, :height, :description)
          end

          def image_params
            return [] unless _image

            [
              _image.url,
              _image.title,
              _image.link,
              _image.width,
              _image.height,
              _image.description
            ]
          end

          def skip_struct
            Struct.new(:hours, :days)
          end

          def skip_params
            [
              skip_hours.hours,
              skip_days.days
            ]
          end
        end

        def self.included(base)
          base.include(InstanceMethods)

          base.element :language
          base.element :copyright
          base.element :managingEditor, as: :managing_editor
          base.element :webMaster, as: :web_master

          base.element :pubDate, as: :pub_date do |date|
            begin
              Time.parse(date)
            rescue
              nil
            end
          end

          base.element :lastBuildDate, as: :last_build_date do |date|
            begin
              Time.parse(date)
            rescue
              nil
            end
          end

          base.elements :category

          base.element :generator

          base.element :docs do |docs|
            Addressable::URI.parse(docs.strip)
          end

          base.element :cloud, as: :_cloud, class: Cloud

          base.element :ttl, &:to_f

          base.element :image, as: :_image, class: Image

          base.element :rating
          base.element :textInput, as: :text_input, class: TextInput, default: Struct.new(:title, :description, :name, :link).new
          base.element :skipHours, as: :skip_hours, class: SkipHours, default: Struct.new(:hours).new([])
          base.element :skipDays, as: :skip_days, class: SkipDays, default: Struct.new(:days).new([])
        end
      end
    end
  end
end
