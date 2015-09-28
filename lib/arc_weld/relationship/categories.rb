module ArcWeld
  module Relationships
    module Categories
      def add_categories(*cats)
        cats.each do |cat|
          unless categories.include?(cat)
            categories << cat.ref
          end
        end
      end

      def categories_relationship
        {
          :inCategory => {
            :list! => (categories.map &:render).join
          }
        }
      end
    end
  end
end