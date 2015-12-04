module Feedjira
  module Podcast
    module Channel
      class AppleCategory
        include SAXMachine
        include FeedUtilities

        CATEGORIES = {
          "Arts" => [
            "Design",
            "Fashion & Beauty",
            "Food",
            "Literature",
            "Performing Arts",
            "Visual Arts"
          ],
          "Business" => [
            "Business News",
            "Careers",
            "Investing",
            "Management & Marketing",
            "Shopping"
          ],
          "Comedy" => [],
          "Education" => [

          ],
          "Games & Hobbies" => [

          ],
          "Government & Organizations" => [

          ],
          "Health" => [

          ],
          "Kids & Family" => [],
          "Music" => [],
          "News & Politics" => [],
          "Religion & Spirituality" => [

          ],
          "Science & Medicine" => [

          ],
          "Society & Culture" => [

          ],
          "Sports & Recreation" => [

          ],
          "Technology" => [

          ],
          "TV & Film" => []
        }

        attribute :text

        elements :"itunes:category", as: :subcategories, class: AppleSubcategory

        def subcategory
          if subcategories.first && subcategories.first.valid?(self)
            subcategories.first
          end
        end

        def valid?
          CATEGORIES.include?(text)
        end
      end
    end
  end
end
