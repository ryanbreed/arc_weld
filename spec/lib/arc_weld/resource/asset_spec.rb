require 'spec_helper'

describe ArcWeld::Asset do
  include_context 'basic assets'

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
end
