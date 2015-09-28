module ArcWeld
  class Asset
    include ArcWeld::Resource
    include ArcWeld::Relationship

    resource_class_id 4
    resource_root     '/All Assets/'
    resource_property :description, :staticAddressing, :hostname, :macAddress, :address

    has_relationship  :location, :zone
    has_relationship  :categories, :alternate_interfaces, multiple: true
  end
end
