require 'spec_helper'
describe ArcWeld::Resource do
  context 'included in class definitions' do
    # class EmptyResource
    #   include ArcWeld::Resource 
    # end

    describe '.included' do
      it 'extends class with ArcWeld::Resource::ClassMethods' do
        expect(SpecClasses::EmptyResource).to respond_to :resource_type
        expect(SpecClasses::EmptyResource).to respond_to :toplevel
        expect(SpecClasses::EmptyResource).to respond_to :class_id
        expect(SpecClasses::EmptyResource).to respond_to :resource_root
        expect(SpecClasses::EmptyResource).to respond_to :resource_class_id
      end
      
      it 'extends class instances with ArcWeld::Resource module methods' do
        er=SpecClasses::EmptyResource.new
        expect(er).to respond_to :resource_type
        expect(er).to respond_to :resource_class_id
      end

      it 'defines resource attribute accessors' do
        er = SpecClasses::EmptyResource.new
        expect(er).to respond_to :name
        expect(er).to respond_to :id
        expect(er).to respond_to :externalID
        expect(er).to respond_to :name=
        expect(er).to respond_to :id=
        expect(er).to respond_to :externalID=
      end

      it 'defines a resource_type method on the class' do
        expect(SpecClasses::EmptyResource.resource_type).to eq('EmptyResource')
      end 

      it 'defines a resource_type method on instances' do
        er = SpecClasses::EmptyResource.new
        expect(er.resource_type).to eq('EmptyResource')
      end 

      it 'sets a class-level instance variable to track properties' do
        expect(SpecClasses::EmptyResource.class_variable_get :@@RESOURCE_PROPERTIES).to eq([])
      end

      it 'defines an initializer that takes keyword arguments' do
        ern=SpecClasses::EmptyResource.new(name: 'empty resource', externalID: 'empty_resource_001')
        expect(ern.name).to eq('empty resource')
        expect(ern.externalID).to eq('empty_resource_001')
      end
    end
  end

  context 'setting class-level attributes' do
    # class BasicResource
    #   include ArcWeld::Resource
    #   resource_class_id 77
    #   resource_root     '/All Basic Resources/'
    # end

    describe '.resource_class_id' do
      it 'sets the class-level instance variable for :@@CLASS_ID' do
        expect(SpecClasses::BasicResource.class_variable_get :@@CLASS_ID).to eq(77)
      end

      it 'defines a class-level getter for class id' do
        expect(SpecClasses::BasicResource).to respond_to :class_id
        expect(SpecClasses::BasicResource.class_id).to eq(77)
      end

    end

    describe '.resource_root' do
      it 'sets the class-level instance variable for :@@RESOURCE_ROOT' do
        expect(SpecClasses::BasicResource.class_variable_get :@@RESOURCE_ROOT).to eq('/All Basic Resources/')
      end
    end

    describe '.toplevel' do
      it 'returns a hash structure representing the top-level resource group' do
        top = SpecClasses::BasicResource.toplevel
        expect(top[:type]).to eq('BasicResource')
        expect(top[:id]).to eq('01000100010001077')
        expect(top[:uri]).to eq('/All Basic Resources/')
      end
    end
  end

  context 'setting resource properties' do
    # class PropertyResource
    #   include ArcWeld::Resource
    #   resource_class_id 78
    #   resource_root     '/All Property Resources/'
    #   resource_property :some_property, :another_property
    # end
    describe '.resource_property' do
      it 'defines getters and setters for named properties' do
        pr = SpecClasses::PropertyResource.new
        expect(pr).to respond_to :some_property
        expect(pr).to respond_to :some_property=
        expect(pr).to respond_to :another_property
        expect(pr).to respond_to :another_property=
      end

      it 'registers properties in the class-level instance @@RESOURCE_PROPTERTIES' do
        expect(SpecClasses::PropertyResource.class_variable_get :@@RESOURCE_PROPERTIES).to eq([:some_property, :another_property])
      end

      it 'makes registered properties available from the class method class_properties' do
        expect(SpecClasses::PropertyResource.class_properties).to eq([:some_property, :another_property])
      end
    end

  end
end
