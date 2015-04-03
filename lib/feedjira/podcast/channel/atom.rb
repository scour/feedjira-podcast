module Feedjira
  module Podcast
    module Channel
      module Atom
        def self.included(base)

          ['self', 'hub'].each do |rel|
            [:"atom:link", :"atom10:link"].each do |ns|
              base.element ns, with: { rel: rel }, as: "atom_#{rel}_link_href".to_sym, value: :href do |href|
                Addressable::URI.parse(href)
              end
              base.element ns, with: { rel: rel }, as: "atom_#{rel}_link_rel".to_sym, value: :rel
              base.element ns, with: { rel: rel }, as: "atom_#{rel}_link_type".to_sym, value: :type
            end
          end

          def atom
            @atom ||= Struct.new(:link).new(atom_link)
          end

          private

          def atom_link
            @atom_link ||= Struct.new(:self, :hub).new(
              atom_link_self,
              atom_link_hub,
            )
          end

          def atom_link_self
            @atom_link_self ||= Struct.new(:href, :rel, :type).new(
              atom_self_link_href,
              atom_self_link_rel,
              atom_self_link_type,
            )
          end

          def atom_link_hub
            @atom_link_hub ||= Struct.new(:href, :rel, :type).new(
              atom_hub_link_href,
              atom_hub_link_rel,
              atom_hub_link_type,
            )
          end

        end
      end
    end
  end
end
