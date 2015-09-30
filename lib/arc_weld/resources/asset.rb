module ArcWeld
  class Asset
    include ArcWeld::Resource
    include ArcWeld::Relationship

    resource_class_id 4
    resource_root     '/All Assets/'
    resource_property :description, :staticAddressing, :hostname, :macAddress, :address

    has_relationship  :has_location, :in_zone
    has_relationship  :in_category, :has_alternate_interface, multiple: true
  end
end
