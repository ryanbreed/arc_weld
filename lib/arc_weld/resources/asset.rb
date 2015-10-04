module ArcWeld
  class Asset
    include ArcWeld::Resource
    include ArcWeld::Relationship

    resource_class_id 4
    resource_root     '/All Assets/'
    resource_property :description, :staticAddressing, :hostname, :macAddress, :address

    has_relationship  :has_location, :in_zone
    has_relationship  :in_category, :has_alternate_interface, :in_network, multiple: true

    def safe_name_from(str)
      str.split('.')[0].gsub(%r{[\/\*:\\]},'-').downcase
    end

    def generate_name
      if staticAddressing=='false' && (hostname!=nil)
        safe_name_from(hostname)
      elsif (address!=nil) && (hostname!=nil)
        format('%s - %s', address, safe_name_from(hostname))
      elsif (address!=nil)
        address
      else
        externalID
      end
    end

    def name
      @name ||= generate_name
    end
  end
end
