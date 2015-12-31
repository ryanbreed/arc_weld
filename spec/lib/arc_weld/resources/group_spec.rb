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
      it 'raises a TypeError exception' do
        expect{ArcWeld::Group.class_id}.to raise_error(TypeError)
      end
    end
    describe '.class_root' do
      it 'raises an exception' do
        expect{ArcWeld::Group.class_root}.to raise_error(TypeError)
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

  context 'referenced from other resources' do
    it 'returns an ArcWeld reference'
    it 'has uri based on the contained resources' do
      group2.add_children(network,network2)
      expect(group2.ref_uri).to eq('/All Networks/spec group 2')
      group3.add_children(customer,customer2)
      expect(group3.ref_uri).to eq('/All Customers/spec group 3')
    end
  end

  context 'rendering xml' do
    it 'renders child relationships' do
      group2.add_children(network,network2)
      expect(group2.render).to eq("<Group name=\"spec group 2\" action=\"insert\" externalID=\"spec_group_002\"><childOf><list><ref type=\"Group\" uri=\"/All Networks/\" id=\"01000100010001040\"/></list></childOf><containedResourceType>40</containedResourceType><description>contained group</description><memberReferencePage>http://bad.horse</memberReferencePage><hasChild><list><ref type=\"Network\" uri=\"/All Networks/spec group 2/spec network\" externalID=\"spec_network_001\"/><ref type=\"Network\" uri=\"/All Networks/spec group 2/spec network 2\" externalID=\"spec_network_002\"/></list></hasChild></Group>")
    end
    it 'renders resource properties' do
      group2.add_children(network,network2)
      expect(group2.render).to eq("<Group name=\"spec group 2\" action=\"insert\" externalID=\"spec_group_002\"><childOf><list><ref type=\"Group\" uri=\"/All Networks/\" id=\"01000100010001040\"/></list></childOf><containedResourceType>40</containedResourceType><description>contained group</description><memberReferencePage>http://bad.horse</memberReferencePage><hasChild><list><ref type=\"Network\" uri=\"/All Networks/spec group 2/spec network\" externalID=\"spec_network_001\"/><ref type=\"Network\" uri=\"/All Networks/spec group 2/spec network 2\" externalID=\"spec_network_002\"/></list></hasChild></Group>")
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