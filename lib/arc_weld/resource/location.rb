module ArcWeld
  class Location
    include ArcWeld::Resource

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

  end
end
