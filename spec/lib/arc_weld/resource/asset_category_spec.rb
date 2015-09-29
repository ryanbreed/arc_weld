require 'spec_helper'

describe ArcWeld::AssetCategory do
  
  include_context 'basic categories'

  context 'class-level configuration' do
    describe '.toplevel' do
      let(:top) { ArcWeld::AssetCategory.toplevel }
      it 'returns a top-level resource reference' do
        expect(top).to be_a(ArcWeld::Reference)
      end
    end
    describe '.class_id' do
      it 'returns the resource type id' do
        expect(ArcWeld::AssetCategory.class_id).to eq(31)
      end
    end
    describe '.class_root' do
      it 'returns the resource base uri'do
        expect(ArcWeld::AssetCategory.class_root).to eq('/All Asset Categories/')
      end

    end
    describe '.resource_type' do
      it 'returns the resource type as a string' do
        expect(ArcWeld::AssetCategory.resource_type).to eq('AssetCategory')
      end
    end
    describe '.class_properties' do
      it 'returns the list of resource properties as an array of symbols' do
        expect(ArcWeld::AssetCategory.class_properties).to eq([:description, :containedResourceType, :memberReferencePage])
      end
    end
  end

  context 'initializing instances' do
    describe '.initialize' do
      it 'initializes from keyword args' do
        expect(category.name).to                eq('spec category 1')
        expect(category.externalID).to          eq('spec_category_001')
        expect(category.description).to         eq('category for resources under test')
        expect(category.memberReferencePage).to eq('https://signed.bad.horse')
      end
    end
  end
end
