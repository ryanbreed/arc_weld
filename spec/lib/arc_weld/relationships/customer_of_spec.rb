require 'spec_helper'

describe ArcWeld::Relationships::CustomerOf do
  include_context 'basic networks'
  include_context 'basic customers'
  context 'describing relationships' do
    describe '.has_relationship :customer_of' do

      it 'defines accessor methods' do
        expect(customer).to respond_to :customer_of
        expect(customer).to respond_to :customer_of=
      end

      it 'is initializes getter with an empty array' do
        expect(customer.customer_of).to be_empty
      end

      it 'defines instance helper methods' do
        expect(customer).to respond_to :add_customer_resource
        expect(customer).to respond_to :add_customer_resources
      end

    end
  end
  context 'relating resources' do
    describe '#add_customer_resources' do
      it 'adds single resource' do
        customer.add_customer_resources(network)
        expect(customer.customer_of).to eq([network])
      end
      it 'adds multiple resources' do
        customer.add_customer_resources(network, network2)
        expect(customer.customer_of).to eq([network, network2])
      end

      it 'does not add the same resource more than once' do
        customer.add_customer_resources(network, network)
        expect(customer.customer_of).to eq([network])
      end
    end
  end
  context 'accessing relationship properties' do
    describe '#customer_of_relationship' do
      it 'is nil when not in any categories' do
        expect(customer.customer_of).to be_empty
      end

      it 'returns the customerOf relationship when populated with single references' do
        customer.add_customer_resources(network)
        rel = customer.customer_of_relationship
        expect(rel).to be_a(Hash)
        expect(rel.keys).to eq(['customerOf'])
        expect(rel['customerOf']).to have_key('list!')
        expect(rel['customerOf']['list!']).to eq("<ref type=\"Network\" uri=\"/All Networks/spec network\" externalID=\"spec_network_001\"/>")
      end

      it 'returns the customerOf relationship when populated with multiple references' do
        customer.add_customer_resources(network, network2)
        rel = customer.customer_of_relationship
        expect(rel['customerOf']['list!']).to eq("<ref type=\"Network\" uri=\"/All Networks/spec network\" externalID=\"spec_network_001\"/><ref type=\"Network\" uri=\"/All Networks/spec network 2\" externalID=\"spec_network_002\"/>")
      end
    end
  end

end