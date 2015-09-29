module ArcWeld
  class AssetCategory
    include ArcWeld::Resource
    include ArcWeld::Relationship

    resource_class_id 31
    resource_root     '/All Asset Categories/'
    
    resource_property :description, :containedResourceType, :memberReferencePage
    
    has_relationship  :has_child, multiple: true

    def ref
      ArcWeld::Reference.new({
          type: 'Group',
          uri:  ref_uri
        }.merge(identity)
      )
    end
    
    def containedResourceType
      resource_class_id
    end
  end
end