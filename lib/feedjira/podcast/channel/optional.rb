module Feedjira
  module Podcast
    module Channel
      module Optional
        def self.included(base)

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

          def categories
            category.map{|c|c.strip}.uniq
          end

          base.element :generator

          base.element :docs do |docs|
            Addressable::URI.parse(docs)
          end

          # base.element :cloud
          # A has five required attributes: domain is the domain name or IP
          # address of the cloud, port is the TCP port that the cloud is running
          # on, path is the location of its responder, registerProcedure is the
          # name of the procedure to call to request notification, and protocol
          # is xml-rpc, soap or http-post (case-sensitive), indicating which
          # protocol is to be used.

          base.element :ttl do |ttl|
            ttl.to_f
          end

          base.element :image, as: :_image, class: Image

          def image
            @image ||= Struct.new(:url, :title, :link, :width, :height, :description).new(
              _image && _image.url,
              _image && _image.title,
              _image && _image.link,
              _image && _image.width,
              _image && _image.height,
              _image && _image.description,
            )
          end

          # base.element :rating
          base.element :textInput, as: :text_input, class: TextInput, default: Struct.new(:title, :description, :name, :link).new
          base.element :skipHours, as: :skip_hours, class: SkipHours
          base.element :skipDays, as: :skip_days, class: SkipDays

          def skip
            @skip ||= Struct.new(:hours, :days).new(
              skip_hours.hours,
              skip_days.days
            )
          end

        end
      end
    end
  end
end
