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
      it 'returns a top-level resource reference' do
        expect(ArcWeld::Asset.toplevel).to be_a(ArcWeld::Reference)
      end
    end
    describe '.class_id' do
      it 'returns the resource type id'
    end
    describe '.class_root' do
      it 'returns the resource base uri'
    end
    describe '.resource_type' do
      it 'returns the resource type as a string'
    end
    describe '.class_properties' do
      it 'returns the list of resource properties as an array of symbols'
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

  context 'relating other resources' do
    describe '#location' do
      it 'has accessor methods defined' do
        expect(asset).to respond_to :location
        expect(asset).to respond_to :location=
      end
    end
    describe '#zone' do
      it 'has accessor methods defined' do
        expect(asset).to respond_to :zone
        expect(asset).to respond_to :zone=
      end
    end
    describe '#categories' do
      it 'is initialized with an empty array' do
        expect(asset.categories).to eq([])
      end
    end
    describe '#alternate_interfaces' do
      it 'is initialized with an empty array' do
        expect(asset.alternate_interfaces).to eq([])
      end
    end
  end
end
