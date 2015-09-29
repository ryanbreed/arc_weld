module SpecClasses

  class EmptyResource
    include ArcWeld::Resource 
  end

  class BasicResource
    include ArcWeld::Resource
    resource_class_id 77
    resource_root     '/All Basic Resources/'
  end
  
  class PropertyResource
    include ArcWeld::Resource
    resource_class_id 78
    resource_root     '/All Property Resources/'
    resource_property :some_property, :another_property
  end
  
  class RelatedResource
    include ArcWeld::Resource
    resource_class_id 79
    resource_root     '/All Related Resources/'
    resource_property :related_property, :second_related_property
  end

  class AnotherRelatedResource
    include ArcWeld::Resource
    resource_class_id 799
    resource_root     '/All Addtional Related Resources/'
    resource_property :another_related_property, :another_second_related_property
  end

  class ResourceWithRelationshipMultiples
    include ArcWeld::Resource
    include ArcWeld::Relationship
    resource_class_id 80
    resource_root     '/All Resources with Relationship Multiples/'
    resource_property :some_property, :another_property
    has_relationship  :related_resource, multiple: true
  end

  class ResourceWithSingleRelationship
    include ArcWeld::Resource
    include ArcWeld::Relationship

    resource_class_id 81
    resource_root     '/All Resources with Single Relationship/'
    resource_property :some_property, :another_property
    has_relationship  :related_resource
  end

  class ResourceWithManyRelationshipTypes
    include ArcWeld::Resource
    include ArcWeld::Relationship
    
    resource_class_id 82
    resource_root     '/All Resources with Many Relationship Types/'
    resource_property :some_property, :another_property
    has_relationship  :related_resource, :another_related_resource
  end
end