require 'spec_helper'

describe ArcWeld::Group do
  include_context 'basic assets'
  include_context 'basic zones'
  include_context 'basic locations'
  include_context 'basic customers'
  include_context 'basic networks'
  include_context 'basic groups'

  context 'class-level configuration' do
    describe '.toplevel' do
      it 'raises an exception' do
        expect{ArcWeld::Group.toplevel}.to raise_error(TypeError)
      end
    end
    describe '.class_id' do
      it 'raises a NameError exception' do
        expect{ArcWeld::Group.class_id}.to raise_error(NameError)
      end
    end
    describe '.class_root' do
      it 'raises an exception' do
        expect{ArcWeld::Group.class_root}.to raise_error(NameError)
      end

    end
    describe '.resource_type' do
      it 'returns the resource type as a string' do
        expect(ArcWeld::Group.resource_type).to eq('Group')
      end
    end
    describe '.class_properties' do
      it 'returns the list of resource properties as an array of symbols' do
        expect(ArcWeld::Group.class_properties).to eq([:containedResourceType, :description, :memberReferencePage])
      end
    end
  end

  context 'initializing instances' do
    describe '.initialize' do
      it 'initializes from keyword args' do
        expect(group.name).to                eq('spec group 1')
        expect(group.externalID).to          eq('spec_group_001')
        expect(group.description).to         eq('group for resources under test')
        expect(group.memberReferencePage).to eq('https://signed.bad.horse')
      end
    end
  end

end  