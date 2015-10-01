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
    describe '#set_zone' do
      it 'assigns zone when self.address is contained' do
        asset.set_zone(zone)
        expect(asset.in_zone).to eq(zone)
      end
      it 'sets staticAddressing when assigned to a zone' do
        asset.set_zone(zone)
        expect(asset.staticAddressing).to eq('false')
      end
      it 'does not assign the zone when self.address is not contained' do
        asset.set_zone(zone2)
        expect(asset.in_zone).to be_nil
      end
    end

    describe '#auto_zone' do
      it 'picks a zone from an array of candidates' do
        asset21.auto_zone(zone, zone2, zone3)
        expect(asset21.in_zone).to eq(zone2)
      end
      it 'picks nothing if not contained in any candidate' do
        asset21.auto_zone(zone, zone3)
        expect(asset21.in_zone).to be_nil
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
