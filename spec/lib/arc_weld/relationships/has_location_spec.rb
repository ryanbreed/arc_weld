require 'spec_helper'
describe ArcWeld::Relationships::HasLocation do
  include_context 'basic assets'
  include_context 'basic zones'
  include_context 'basic locations'

  context 'describing relationships' do
    describe '.has_relationship :has_location' do
      it 'defines accessor methods' do
        expect(asset).to respond_to :has_location
        expect(asset).to respond_to :has_location=
      end
    end
  end
  context 'accessing relationship properties' do
    describe '#has_location_relationship' do
      it 'is nil when #has_location is not set' do
        expect(asset.has_location_relationship).to be_nil
      end
      it 'includes the hasLocation relationship when set' do
        asset.has_location = location
        rel = asset.has_location_relationship
        expect(rel).to be_a(Hash)
        expect(rel.keys).to eq(['hasLocation'])
        expect(rel['hasLocation']).to have_key('list!')
        expect(rel['hasLocation']['list!']).to eq('<ref type="Location" uri="/All Locations/spec location" externalID="spec_location_000"/>')
      end
    end
  end
end