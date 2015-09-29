require 'spec_helper'

describe ArcWeld::Relationships::HasAlternateInterface do
  include_context 'basic assets'

  context 'describing relationship' do
    describe '.has_relationship :has_alternate_interface' do
      it 'defines accessor methods on object instances' do
        expect(asset).to respond_to :has_alternate_interface
        expect(asset).to respond_to :has_alternate_interface=
      end
      it 'is initialized with an empty array when declared multiple' do
        expect(asset.has_alternate_interface).to eq([])
      end
    end
  end

  context 'accessing relationship properties' do
    describe '#has_alternate_interface_relationship' do
      it 'is nil when no alternate interfaces assigned' do
        expect(asset.has_alternate_interface_relationship).to be_nil
      end

      it 'returns the hasAlternateInterface relationship when populated with single references' do
        asset.add_interfaces(asset2)
        rel = asset.has_alternate_interface_relationship
        expect(rel).to be_a(Hash)
        expect(rel.keys).to eq(['hasAlternateInterface','alternateInterfaceOf'])
        expect(rel['hasAlternateInterface']).to have_key('list!')
        expect(rel['alternateInterfaceOf']).to have_key('list!')
        expect(rel['hasAlternateInterface']['list!']).to eq("<ref type=\"Asset\" uri=\"/All Assets/192.168.2.2 - asset22.local\" externalID=\"spec_asset_22\"/>")
        expect(rel['alternateInterfaceOf']['list!']).to eq("<ref type=\"Asset\" uri=\"/All Assets/192.168.2.2 - asset22.local\" externalID=\"spec_asset_22\"/>")

      end
      it 'returns the HasAlternateInterface relationship when populated with multiple references' do
        asset.add_interfaces(asset2, asset3)
        rel = asset.has_alternate_interface_relationship
        expect(rel['hasAlternateInterface']['list!']).to eq("<ref type=\"Asset\" uri=\"/All Assets/192.168.2.2 - asset22.local\" externalID=\"spec_asset_22\"/><ref type=\"Asset\" uri=\"/All Assets/192.168.2.3 - asset23.local\" externalID=\"spec_asset_23\"/>")
        expect(rel['alternateInterfaceOf']['list!']).to eq("<ref type=\"Asset\" uri=\"/All Assets/192.168.2.2 - asset22.local\" externalID=\"spec_asset_22\"/><ref type=\"Asset\" uri=\"/All Assets/192.168.2.3 - asset23.local\" externalID=\"spec_asset_23\"/>")
      end
    end
  end
end