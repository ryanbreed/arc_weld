module ArcWeld
  module Relationships
    module HasCustomer
      def add_customer(cust)
        unless has_customer.include?(cust)
          has_customer.push(cust)
          cust.add_customer_resource(self)
        end
      end

      def add_customers(*customers)
        customers.each { |cust| add_customer(cust) }
      end

      def related_has_customer_references
        (has_customer.map { |cust| cust.ref.render }).join
      end

      def has_customer_relationship
        unless has_customer.empty?
          { 'hasCustomer' => {
              'list!' => related_has_customer_references
          }}
        end
      end
    end
  end
end
