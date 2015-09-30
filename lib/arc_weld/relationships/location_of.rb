module ArcWeld
  module Relationships
    module LocationOf
      def add_location_resource(res)
        unless location_of.include?(res)
          location_of.push(res)
          res.has_location=self unless res.has_location==self
        end
      end

      def add_location_resources(*resources)
        resources.each { |res| add_location_resource(res) }
      end

      def related_location_of_references
        (location_of.map { |resource| resource.ref.render }).join
      end

      def customer_of_relationship
        unless customer_of.empty?
          { 'locationOf' => {
              'list!' => related_location_of_references
          }}
        end
      end
    end
  end
end
