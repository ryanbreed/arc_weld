module ArcWeld
  module Relationships
    module SpecRelationship
      def decorated_method
        'decorate!'
      end
    end
    module SpecRelationshipWithAccessorOverride
      def decorated_method
        'decorate!'
      end
      def spec_relationship_with_accessor_override
        'overridden getter'
      end
      def spec_relationship_with_accessor_override=(foo)
        @override='overridden setter'
      end
    end
  end
end

module SpecExtendedClasses
  class ResourceWithExtendedRelationship
    include ArcWeld::Resource
    include ArcWeld::Relationship
    
    resource_class_id 92
    resource_root     '/All Resources with Extended Relationships/'
    resource_property :some_property, :another_property
    has_relationship  :spec_relationship
  end

  class ResourceWithOverriddenRelationshipAccessor
    include ArcWeld::Resource
    include ArcWeld::Relationship
    
    resource_class_id 98
    resource_root     '/All Resources with Extended Relationships that Override the Relationship Accessor Methods/'
    resource_property :some_property, :another_property
    has_relationship  :spec_relationship_with_accessor_override
  end
end