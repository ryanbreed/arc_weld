module ArcWeld
  class Cusomer
    include ArcWeld::Resource
    include ArcWeld::Relationship

    resource_class_id 35
    resource_root     '/All Customers/'
    resource_property :streetAddress1,
                      :streetAddress2,
                      :addressState,
                      :country

    has_relationship :network
  end
end
