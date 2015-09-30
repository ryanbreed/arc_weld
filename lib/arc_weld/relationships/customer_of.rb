module ArcWeld
  module Relationships
    module CustomerOf
      def add_customer_resource(res)
        unless customer_of.include?(res)
          customer_of.push(res)
          res.add_customer(self)
        end
      end

      def add_customer_resources(*resources)
        resources.each { |res| add_customer_resource(res) }
      end

      def related_customer_of_references
        (customer_of.map { |resource| resource.ref.render }).join
      end

      def customer_of_relationship
        unless customer_of.empty?
          { 'customerOf' => {
              'list!' => related_customer_of_references
          }}
        end
      end
    end
  end
end
