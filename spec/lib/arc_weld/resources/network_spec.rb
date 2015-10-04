require 'spec_helper'

describe ArcWeld::Network do
  
  include_context 'basic networks'

  context 'class-level configuration' do
    describe '.toplevel' do
      let(:top) { ArcWeld::Network.toplevel }
      it 'returns a top-level resource reference' do
        expect(top).to be_a(ArcWeld::Reference)
      end
    end
    describe '.class_id' do
      it 'returns the resource type id' do
        expect(ArcWeld::Network.class_id).to eq(40)
      end
    end
    describe '.class_root' do
      it 'returns the resource base uri'do
        expect(ArcWeld::Network.class_root).to eq('/All Networks/')
      end
    end

    describe '.resource_type' do
      it 'returns the resource type as a string' do
        expect(ArcWeld::Network.resource_type).to eq('Network')
      end
    end
    describe '.class_properties' do
      it 'returns the list of resource properties as an array of symbols' do
        expect(ArcWeld::Network.class_properties).to eq([:description])
      end
    end
  end

  context 'initializing instances' do
    describe '.initialize' do
      it 'initializes from keyword args' do
        expect(network.name).to        eq('spec network')
        expect(network.externalID).to  eq('spec_network_001')
        expect(network.description).to eq('spec network')
      end
    end
  end
end
