module ArcWeld
  module Relationships
    module InCategory

      def add_category(cat)
        unless in_category.include?(cat.ref)
          in_category << cat.ref
        end
      end

      def add_categories(*cats)
        cats.each { |cat| add_category(cat) }
      end

      def related_in_category_references
        (in_category.map &:render).join
      end

      def in_category_relationship
        unless in_category.empty?
          { 'inCategory' => { 'list!' => related_in_category_references } }
        end
      end
    end
  end
end
