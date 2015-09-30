module ArcWeld
  class Location
    include ArcWeld::Resource
    include ArcWeld::Relationship

    resource_class_id 39
    resource_root     '/All Locations/'
    resource_property :countryCode,
                      :city,
                      :countryName,
                      :description,
                      :latitude,
                      :longitude,
                      :postalCode,
                      :regionCode
    has_relationship :location_of, multiple: true
  end
end
