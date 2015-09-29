require 'spec_helper'

describe ArcWeld::Relationships::InZone do
  include_context 'basic assets'
  include_context 'basic zones'
  
  context 'describing relationship' do
    describe '.has_relationship :in_zone' do
      it 'defines accessor methods' do
        expect(asset).to respond_to :in_zone
        expect(asset).to respond_to :in_zone=
      end
      it 'defines helper methods on the instance' do
        expect(asset).to respond_to :auto_zone
      end
    end
  end

  context 'relating resources' do
    describe '#in_zone=' do
      it 'assigns the related zone if address is between startAddress and endAddress' do
        asset.in_zone = zone
        expect(asset.in_zone).to eq(zone)       
      end
      it 'raises a RuntimeError if address is not between startAddress and endAddress' do
        expect { asset.in_zone=zone2 }.to raise_error(RuntimeError)
      end
    end
  end
  context 'accessing relationship properties' do
    describe '#in_zone_relationship' do
      it 'is nil when #in_zone is not set' do
        expect(asset.in_zone_relationship).to be_nil
      end

      it 'returns the inZone relationship when set' do
        asset.in_zone = zone
        rel = asset.in_zone_relationship
        expect(rel).to be_a(Hash)
        expect(rel.keys).to eq(['inZone'])
        expect(rel['inZone']).to have_key('list!')
        expect(rel['inZone']['list!']).to eq("<ref type=\"Zone\" uri=\"/All Zones/spec zone - 192.168.1.0-24\" externalID=\"spec_zone_001\"/>")
      end
    end
  end
end  