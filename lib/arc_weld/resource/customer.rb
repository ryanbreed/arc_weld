module ArcWeld
  class Customer
    include ArcWeld::Resource
    include ArcWeld::Relationship

    resource_class_id 35
    resource_root     '/All Customers/'
    resource_property :description,
                      :streetAddress1,
                      :streetAddress2,
                      :addressState,
                      :country

    has_relationship :in_network
  end
end
