require 'spec_helper'

describe ArcWeld::Customer do
  include_context 'basic assets'
  include_context 'basic customers'

  context 'class-level configuration' do
    describe '.toplevel' do
      let(:top) { ArcWeld::Customer.toplevel }
      it 'returns a top-level resource reference' do
        expect(top).to be_a(ArcWeld::Reference)
      end
    end
    describe '.class_id' do
      it 'returns the resource type id' do
        expect(ArcWeld::Customer.class_id).to eq(35)
      end
    end
    describe '.class_root' do
      it 'returns the resource base uri'do
        expect(ArcWeld::Customer.class_root).to eq('/All Customers/')
      end

    end
    describe '.resource_type' do
      it 'returns the resource type as a string' do
        expect(ArcWeld::Customer.resource_type).to eq('Customer')
      end
    end
    describe '.class_properties' do
      it 'returns the list of resource properties as an array of symbols' do
        expect(ArcWeld::Customer.class_properties).to eq([:description, :streetAddress1, :streetAddress2, :addressState, :country])
      end
    end
  end

  context 'initializing instances' do
    describe '.initialize' do
      it 'initializes from keyword args' do
        expect(customer.name).to           eq('spec customer')
        expect(customer.externalID).to     eq('spec_customer_001')
        expect(customer.streetAddress1).to eq('address line 1')
        expect(customer.streetAddress2).to eq('address line 2')
        expect(customer.addressState).to   eq('Texas')
        expect(customer.country).to        eq('United States')
      end
    end
  end
end
