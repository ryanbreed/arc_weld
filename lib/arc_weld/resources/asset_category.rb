module ArcWeld
  class AssetCategory
    include ArcWeld::Resource
    include ArcWeld::Relationship

    resource_class_id 31
    resource_root     '/All Asset Categories/'
    
    resource_property :description, :containedResourceType, :memberReferencePage
    
    has_relationship  :has_child, multiple: true

    # @OVERRIDE
    def ref
      ArcWeld::Reference.new({
          type: 'Group',
          uri:  ref_uri
        }.merge(identity)
      )
    end
    
    # @OVERRIDE
    def containedResourceType
      resource_class_id
    end

    # @OVERRIDE
    def to_h
      resource_h = {
        'Group' => {
          'childOf' => { 'list!' => parent_ref.render },
          '@name'   => name,
          '@action' => action
        }.merge(identity_hash)
         .merge(property_hash)
         .merge(relationship_hash)
      }
    end
  end
end