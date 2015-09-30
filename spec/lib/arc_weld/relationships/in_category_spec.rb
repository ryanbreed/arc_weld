require 'spec_helper'

describe ArcWeld::Relationships::InCategory do
  include_context 'basic assets'
  include_context 'basic zones'
  include_context 'basic categories'
  context 'describing relationships' do
    describe '.has_relationship :in_category' do

      it 'defines accessor methods' do
        expect(asset).to respond_to :in_category
        expect(asset).to respond_to :in_category=
      end

      it 'is initializes getter with an empty array' do
        expect(asset.in_category).to eq([])
      end

    end
  end
  context 'accessing relationship properties' do
    describe '#in_category_relationship' do
      it 'is nil when not in any categories' do
        expect(asset.in_category_relationship).to be_nil
      end

      it 'returns the inCategory relationship when populated with single references' do
        asset.add_categories(category)
        rel = asset.in_category_relationship
        expect(rel).to be_a(Hash)
        expect(rel.keys).to eq(['inCategory'])
        expect(rel['inCategory']).to have_key('list!')
        expect(rel['inCategory']['list!']).to eq("<ref type=\"Group\" uri=\"/All Asset Categories/spec category 1\" externalID=\"spec_category_001\"/>")
      end
      it 'returns the inCategory relationship when populated with multiple references' do
        asset.add_categories(category, category2)
        rel = asset.in_category_relationship
        expect(rel['inCategory']['list!']).to eq("<ref type=\"Group\" uri=\"/All Asset Categories/spec category 1\" externalID=\"spec_category_001\"/><ref type=\"Group\" uri=\"/All Asset Categories/spec category 2\" externalID=\"spec_category_002\"/>")
      end
    end
  end
  context 'relating resources' do
    describe '#add_categories' do
      it 'adds single categories as references' do
        asset.add_categories(category)
        expect(asset.in_category).to eq([category.ref])
      end

      it 'adds multiple categories as references' do
        asset.add_categories(category, category2)
        expect(asset.in_category).to eq([category.ref, category2.ref])
      end

      it 'does not add the same category more than once' do
        asset.add_categories(category)
        asset.add_categories(category, category)
        expect(asset.in_category).to eq([category.ref])
      end
    end
  end
end