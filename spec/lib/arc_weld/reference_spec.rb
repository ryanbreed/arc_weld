require 'spec_helper'
describe ArcWeld::Reference do
  context 'creating instances' do
    describe '.initialize' do
      it 'creates new instances from keyword arguments' do
        spec_ref = ArcWeld::Reference.new(
          type:       'SpecResourceRef',
          id:         'zazzle',
          externalID: 'ext_zazzle',
          uri:        '/All Somethings/somewhere/Some Thing')
        expect(spec_ref.type).to       eq('SpecResourceRef')
        expect(spec_ref.id).to         eq('zazzle')
        expect(spec_ref.externalID).to eq('ext_zazzle')
        expect(spec_ref.uri).to        eq('/All Somethings/somewhere/Some Thing')
      end
    end
  end
  context 'comparing instances' do
    describe '#==' do
      it 'returns true for different instances with identical attributes' do
        ref_one = ArcWeld::Reference.new( type: 'SpecRef', id: 'zazzle', externalID: 'ext_zazzle', uri: '/All SpecRefs/Zazzle')
        ref_two = ArcWeld::Reference.new( type: 'SpecRef', id: 'zazzle', externalID: 'ext_zazzle', uri: '/All SpecRefs/Zazzle')
        expect(ref_one).to eq(ref_two)
      end
      it 'returns false for instances with differing id attributes' do
        ref_one = ArcWeld::Reference.new( type: 'SpecRef', id: 'zazzle_1', externalID: 'ext_zazzle', uri: '/All SpecRefs/Zazzle')
        ref_two = ArcWeld::Reference.new( type: 'SpecRef', id: 'zazzle_2', externalID: 'ext_zazzle', uri: '/All SpecRefs/Zazzle')
        expect(ref_one).not_to eq(ref_two)
      end
      it 'returns false for instances with differing externalID attributes' do
        ref_one = ArcWeld::Reference.new( type: 'SpecRef', id: 'zazzle', externalID: 'ext_zazzle_1', uri: '/All SpecRefs/Zazzle')
        ref_two = ArcWeld::Reference.new( type: 'SpecRef', id: 'zazzle', externalID: 'ext_zazzle_2', uri: '/All SpecRefs/Zazzle')
        expect(ref_one).not_to eq(ref_two)
      end
      it 'returns false for instances with differing uri attributes' do
        ref_one = ArcWeld::Reference.new( type: 'SpecRef', id: 'zazzle', externalID: 'ext_zazzle', uri: '/All SpecRefs/Zazzle/one')
        ref_two = ArcWeld::Reference.new( type: 'SpecRef', id: 'zazzle', externalID: 'ext_zazzle', uri: '/All SpecRefs/Zazzle/two')
        expect(ref_one).not_to eq(ref_two)
      end
      it 'returns false for instances with differing type attributes' do
        ref_one = ArcWeld::Reference.new( type: 'SpecRef1', id: 'zazzle', externalID: 'ext_zazzle', uri: '/All SpecRefs/Zazzle')
        ref_two = ArcWeld::Reference.new( type: 'SpecRef2', id: 'zazzle', externalID: 'ext_zazzle', uri: '/All SpecRefs/Zazzle')
        expect(ref_one).not_to eq(ref_two)
      end
    end
  end
  context 'rendering xml' do
    describe '#identity' do
      it 'renders the identity attribute' do
        ref_one = ArcWeld::Reference.new( type: 'SpecRef', id: 'zazzle', externalID: 'ext_zazzle', uri: '/All SpecRefs/Zazzle')
        expect(ref_one.render).to eq("<ref type=\"SpecRef\" uri=\"/All SpecRefs/Zazzle\" id=\"zazzle\"/>")
      end
    end
    describe '#identity_hash' do
      it 'renders the identity attribute as a gyoku attrubute hash' do
        ref_one = ArcWeld::Reference.new( type: 'SpecRef', id: 'zazzle', externalID: 'ext_zazzle', uri: '/All SpecRefs/Zazzle')
        expect(ref_one.identity_hash).to eq({"@id"=>"zazzle"})
      end
    end

    describe '#render' do
      it 'renders references with an id attribute' do
        with_id = ArcWeld::Reference.new( type: 'Group', id: 'zazzle', uri: '/All Somethings/somewhere/Some Thing')
        expect(with_id.render).to eq('<ref type="Group" uri="/All Somethings/somewhere/Some Thing" id="zazzle"/>')
      end
      it 'renders references with an externalID attribute' do
        with_externalID = ArcWeld::Reference.new( type: 'Group', externalID: 'ext_zazzle', uri: '/All Somethings/somewhere/Some Thing')
        expect(with_externalID.render).to eq('<ref type="Group" uri="/All Somethings/somewhere/Some Thing" externalID="ext_zazzle"/>')
      end
      it 'renders references without an id or externalID attribute' do
        no_id = ArcWeld::Reference.new( type: 'Group', uri: '/All Somethings/somewhere/Some Thing')
        expect(no_id.render).to eq('<ref type="Group" uri="/All Somethings/somewhere/Some Thing"/>')
      end
      it 'renders references with id if both id attributes are set' do
        with_both = ArcWeld::Reference.new( type: 'Group', id: 'zazzle', externalID: 'ext_zazzle', uri: '/All Somethings/somewhere/Some Thing')
        expect(with_both.render).to eq('<ref type="Group" uri="/All Somethings/somewhere/Some Thing" id="zazzle"/>')
      end
    end
  end
end
