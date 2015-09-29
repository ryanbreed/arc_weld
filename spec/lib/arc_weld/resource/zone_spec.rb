require 'spec_helper'

describe ArcWeld::Zone do
  
  include_context 'basic zones'

  context 'class-level configuration' do
    describe '.toplevel' do
      let(:top) { ArcWeld::Zone.toplevel }
      it 'returns a top-level resource reference' do
        expect(top).to be_a(ArcWeld::Reference)
      end
    end
    describe '.class_id' do
      it 'returns the resource type id' do
        expect(ArcWeld::Zone.class_id).to eq(29)
      end
    end
    describe '.class_root' do
      it 'returns the resource base uri'do
        expect(ArcWeld::Zone.class_root).to eq('/All Zones/')
      end
    end

    describe '.resource_type' do
      it 'returns the resource type as a string' do
        expect(ArcWeld::Zone.resource_type).to eq('Zone')
      end
    end
    describe '.class_properties' do
      it 'returns the list of resource properties as an array of symbols' do
        expect(ArcWeld::Zone.class_properties).to eq([:description, :dynamicAddressing, :startAddress, :endAddress])
      end
    end
  end

  context 'initializing instances' do
    describe '.initialize' do
      it 'initializes from keyword args' do
        expect(zone.name).to               eq('spec zone - 192.168.1.0-24')
        expect(zone.externalID).to         eq('spec_zone_001')
        expect(zone.description).to        eq('spec zone')
        expect(zone.startAddress).to       eq('192.168.1.0')
        expect(zone.endAddress).to         eq('192.168.1.255')
        expect(zone.dynamicAddressing).to  eq('true')
      end
    end
  end
end
