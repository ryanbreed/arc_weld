require 'spec_helper'
describe ArcWeld::Relationship do
  context 'including in class definitions' do
    # class ResourceWithRelationshipMultiples
    #   include ArcWeld::Resource
    #   include ArcWeld::Relationship
    #   resource_class_id 80
    #   resource_root     '/All Resources with Relationship Multiples/'
    #   resource_property :some_property, :another_property
    #   has_relationship  :related_resource, multiple: true
    # end
    describe '.included' do
      let (:rwrm) { SpecClasses::ResourceWithRelationshipMultiples }
      it 'defines a class-level instance variable to track relationship types' do
        expect(rwrm.class_variable_get :@@RELATIONSHIPS).to eq([:related_resource])
      end

      it 'defines a class-level getter for relationship type tracking' do
        expect(rwrm.class_relationship_types).to eq([:related_resource])
      end

      it 'defines a class method for describing relationships' do
        expect(rwrm).to respond_to :has_relationship
      end
    end
  end
  context 'adding helpers from the relationship module' do
    let(:rwer) { SpecExtendedClasses::ResourceWithExtendedRelationship }
    let(:rwer_instance) { rwer.new } 
    it 'defines instance methods' do
      expect(rwer_instance).to respond_to :decorated_method
      expect(rwer_instance.decorated_method).to eq('decorate!')
    end

    let(:rwora) { SpecExtendedClasses::ResourceWithOverriddenRelationshipAccessor }
    let(:rwora_instance) { rwora.new }
    it 'can override default relationship accessor' do
      expect(rwora_instance.spec_relationship_with_accessor_override).to eq('overridden getter')
      rwora_instance.spec_relationship_with_accessor_override='wibble'
      expect(rwora_instance.instance_variable_get :@override).to eq('overridden setter')
    end
  end
  context 'describing relationships' do
    describe '.register_relationship' do
      let (:rwrm_instance) { SpecClasses::ResourceWithRelationshipMultiples.new }
      
      it 'defines a getter method for the relationship name' do
        expect(rwrm_instance).to respond_to :related_resource
      end

      it 'defines a default value for the relationship if multiple' do
        expect(rwrm_instance.related_resource).to eq([])
      end

      it 'defines a setter method for the relationship name' do
        expect(rwrm_instance).to respond_to :related_resource=
      end
    end
    describe '.has_relationship' do
      context 'single relationship type' do
        # class ResourceWithSingleRelationship
        #   include ArcWeld::Resource
        #   resource_class_id 81
        #   resource_root     '/All Resources with Single Relationship/'
        #   resource_property :some_property, :another_property
        #   has_relationship  :related_resource
        # end

        let (:rwsr) { SpecClasses::ResourceWithSingleRelationship }
        let (:rwsr_instance) { rwsr.new }

        it 'sets relationship tracking in the resource class' do
          expect(rwsr.class_relationship_types).to eq([:related_resource])
        end

        it 'defines accessors for single relationship types' do
          expect(rwsr_instance).to respond_to :related_resource
          expect(rwsr_instance).to respond_to :related_resource=
        end
      end
      
      context 'multiple relationship types' do
        let (:rwmrt) { SpecClasses::ResourceWithManyRelationshipTypes }
        let (:rwmrt_instance) { rwmrt.new }
        it 'sets tracking for all relationship types' do
          expect(rwmrt.class_relationship_types).to eq([:related_resource, :another_related_resource])
        end

        it 'defines accessor methods for all relationship types' do
          expect(rwmrt_instance).to respond_to :related_resource
          expect(rwmrt_instance).to respond_to :related_resource=
          expect(rwmrt_instance).to respond_to :another_related_resource
          expect(rwmrt_instance).to respond_to :another_related_resource=
        end

      end
    end
  end
end
