module ArcWeld
  class Network
    include ArcWeld::Resource
    include ArcWeld::Relationship

    resource_class_id 40
    resource_root     '/All Networks/'
    resource_property :description

    has_relationship :customers, multiple: true
    has_relationship :location
    
  end
end