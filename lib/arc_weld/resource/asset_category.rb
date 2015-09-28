module ArcWeld
  class AssetCategory
    include ArcWeld::Resource
    include ArcWeld::Relationship

    resource_class_id 31
    resource_root     '/All Asset Categories/'
    resource_property :description, :containedResourceType, :memberReferencePage

  end
end