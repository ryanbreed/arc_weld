require 'spec_helper'
describe ArcWeld::Relationships::HasChild do
  include_context 'basic groups'
  include_context 'basic assets'
  include_context 'basic zones'

  context 'describing the relationship' do
    describe '.has_relationship :has_child' do
      it 'defines accessor methods' do
        expect(group).to respond_to :has_child
        expect(group).to respond_to :has_child=
      end
      it 'defines helper methods' do
        expect(group).to respond_to :related_has_child_resources
        expect(group).to respond_to :has_child_relationship
        expect(group).to respond_to :add_child
        expect(group).to respond_to :add_children
        expect(group).to respond_to :contains_resource_type
      end
    end
  end
  context 'accessing relationship properties'
  context 'adding children' do
    describe '#containedResourceType' do
      it 'is nil until children are added' do
        expect(group.containedResourceType).to be_nil
      end
    end
    describe '#add_child' do
      let(:group_with_asset) { group.add_child(asset); group }
      it 'updates the contained resource type to match the child' do
        expect(group_with_asset.containedResourceType).to eq(4)
      end
      it 'updates the parent_ref to match the child.class.toplevel' do
        expect(group_with_asset.parent_ref).to eq(ArcWeld::Asset.toplevel)
      end
      it 'raises an exception if a conflicting asset type is added' do
        expect{ group_with_asset.add_child(zone) }.to raise_error(RuntimeError)
      end
    end
  end
end