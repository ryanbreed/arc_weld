require 'spec_helper'

describe ArcWeld::Relationships::HasCustomer do
  include_context 'basic networks'
  include_context 'basic customers'
  context 'describing relationships' do
    describe '.has_relationship :has_customer' do

      it 'defines accessor methods' do
        expect(network).to respond_to :has_customer
        expect(network).to respond_to :has_customer=
      end

      it 'is initializes getter with an empty array' do
        expect(network.has_customer).to be_empty
      end

      it 'defines instance helper methods' do
        expect(network).to respond_to :add_customer
        expect(network).to respond_to :add_customers
      end

    end
  end
  context 'relating resources' do
    it 'reflexively adds relationships on target resources'
    describe '#add_customers' do
      it 'adds single resource' do
        network.add_customers(customer)
        expect(network.has_customer).to eq([customer])
      end
      it 'adds multiple resources' do
        network.add_customers(customer, customer2)
        expect(network.has_customer).to eq([customer, customer2])
      end

      it 'does not add the same resource more than once' do
        network.add_customers(customer, customer)
        expect(network.has_customer).to eq([customer])
      end
    end
  end
  context 'accessing relationship properties' do
    describe '#has_customer_relationship' do
      it 'is nil when not in any categories' do
        expect(network.has_customer).to be_empty
      end

      it 'returns the hasCustomer relationship when populated with single references' do
        network.add_customers(customer)
        rel = network.has_customer_relationship
        expect(rel).to be_a(Hash)
        expect(rel.keys).to eq(['hasCustomer'])
        expect(rel['hasCustomer']).to have_key('list!')
        expect(rel['hasCustomer']['list!']).to eq("<ref type=\"Customer\" uri=\"/All Customers/spec customer\" externalID=\"spec_customer_001\"/>")
      end

      it 'returns the hasCustomer relationship when populated with multiple references' do
        network.add_customers(customer, customer2)
        rel = network.has_customer_relationship
        expect(rel['hasCustomer']['list!']).to eq("<ref type=\"Customer\" uri=\"/All Customers/spec customer\" externalID=\"spec_customer_001\"/><ref type=\"Customer\" uri=\"/All Customers/spec customer 2\" externalID=\"spec_customer_002\"/>")
      end
    end
  end

end