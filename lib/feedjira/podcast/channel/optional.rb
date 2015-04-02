module Feedjira
  module Podcast
    module Channel
      module Optional
        def self.included(base)

          base.element :language
          base.element :copyright
          base.element :managingEditor
          base.element :webMaster

        end
      end
    end
  end
end
