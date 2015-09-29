require 'spec_helper'

describe ArcWeld::Asset do
  let(:asset) {ArcWeld::Asset.new(
    name:        '192.168.1.1 - asset01.local',
    address:     '192.168.1.1',
    macAddress:  'be:ef:be:ef:be:ef',
    hostname:    'asset01.local',
    description: 'spec asset 1',
    externalID:  'spec_asset_01'
  )}

  context 'class-level configuration' do
    describe '.toplevel' do
      let(:top) { ArcWeld::Asset.toplevel }
      it 'returns a top-level resource reference' do
        expect(top).to be_a(ArcWeld::Reference)
      end
    end
    describe '.class_id' do
      it 'returns the resource type id' do
        expect(ArcWeld::Asset.class_id).to eq(4)
      end
    end
    describe '.class_root' do
      it 'returns the resource base uri'do
        expect(ArcWeld::Asset.class_root).to eq('/All Assets/')
      end

    end
    describe '.resource_type' do
      it 'returns the resource type as a string' do
        expect(ArcWeld::Asset.resource_type).to eq('Asset')
      end
    end
    describe '.class_properties' do
      it 'returns the list of resource properties as an array of symbols' do
        expect(ArcWeld::Asset.class_properties).to eq([:description, :staticAddressing, :hostname, :macAddress, :address])
      end
    end
  end

  context 'initializing instances' do
    describe '.initialize' do
      it 'initializes from keyword args' do
        expect(asset.name).to eq('192.168.1.1 - asset01.local')
        expect(asset.address).to eq('192.168.1.1')
        expect(asset.macAddress).to eq('be:ef:be:ef:be:ef')
        expect(asset.hostname).to eq('asset01.local')
        expect(asset.description).to eq('spec asset 1')
        expect(asset.externalID).to eq('spec_asset_01')
      end
    end
  end

  context 'describing relationships' do
    describe '#location' do
      it 'has accessor methods defined' do
        expect(asset).to respond_to :has_location
        expect(asset).to respond_to :has_location=
      end
    end
    describe '#zone' do
      it 'has accessor methods defined' do
        expect(asset).to respond_to :in_zone
        expect(asset).to respond_to :in_zone=
      end
    end
    describe '#categories' do
      it 'is initialized with an empty array' do
        expect(asset.in_category).to eq([])
      end
    end
    describe '#alternate_interfaces' do
      it 'is initialized with an empty array' do
        expect(asset.has_alternate_interface).to eq([])
      end
    end
  end
  context 'relating other to other asset types' do
    let(:location) { ArcWeld::Location.new(
      name: 'spec_location',
      externalID: 'spec_location_000',
      latitude: 0.0,
      longitude: 0.0
    )}

    let(:category1) { ArcWeld::AssetCategory.new(
      name:       'spec category 01',
      externalID: 'spec_category_01'
    )}

    let(:category2) { ArcWeld::AssetCategory.new(
      name:       'spec category 02',
      externalID: 'spec_category_02'
    )}

    let(:zone) { ArcWeld::Zone.new(
      name:        'spec zone - 192.168.1.0-24',
      cidr:        '192.168.1.0/24',
      description: 'spec zone'
    )}

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
        expect(rel['hasLocation']['list!']).to eq('<ref type="Location" uri="/All Locations/spec_location" externalID="spec_location_000"/>')
      end
    end

    describe '#in_zone_relationship' do
      it 'is nil when #in_zone is not set' do
        expect(asset.in_zone_relationship).to be_nil
      end
      it 'includes the hasLocation relationship when set' do
        asset.in_zone = zone
        rel = asset.in_zone_relationship
        expect(rel).to be_a(Hash)
        expect(rel.keys).to eq(['hasLocation'])
        expect(rel['hasLocation']).to have_key('list!')
        expect(rel['hasLocation']['list!']).to eq('<ref type="Location" uri="/All Locations/spec_location" externalID="spec_location_000"/>')
      end
    end

    describe '#add_categories' do
      it 'adds single categories as references' do
        asset.add_categories(category1)
        expect(asset.in_category).to eq([category1.ref])
      end

      it 'adds multiple categories as references' do
        asset.add_categories(category1, category2)
        expect(asset.in_category).to eq([category1.ref, category2.ref])
      end

      it 'does not add the same category more than once' do
        asset.add_categories(category1)
        asset.add_categories(category1, category1)
        expect(asset.in_category).to eq([category1.ref])
      end
    end

    describe '#in_category_relationship' do
      it 'is nil when not in any categories' do
        expect(asset.in_category_relationship).to be_nil
      end

      it 'includes the inCategory relationship when populated with single references' do
        asset.add_categories(category1)
        rel = asset.in_category_relationship
        expect(rel).to be_a(Hash)
        expect(rel.keys).to eq(['inCategory'])
        expect(rel['inCategory']).to have_key('list!')
        expect(rel['inCategory']['list!']).to eq("<ref type=\"Group\" uri=\"/All Asset Categories/spec category 01\" externalID=\"spec_category_01\"/>")
      end
      it 'includes the inCategory relationship when populated with multiple references' do
        asset.add_categories(category1, category2)
        rel = asset.in_category_relationship
        expect(rel['inCategory']['list!']).to eq("<ref type=\"Group\" uri=\"/All Asset Categories/spec category 01\" externalID=\"spec_category_01\"/><ref type=\"Group\" uri=\"/All Asset Categories/spec category 02\" externalID=\"spec_category_02\"/>")
      end
    end
  end
end
