module ArcWeld
  module Relationships
    module Categories
      def add_categories(*cats)
        cats.each do |cat|
          unless categories.include?(cat)
            categories << cat
          end
        end
      end
    end
  end
end