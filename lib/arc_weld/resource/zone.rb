module ArcWeld
  class Zone
    include ArcWeld::Resource
    include ArcWeld::Relationship

    resource_class_id 29
    resource_root     '/All Zones/'
    resource_property :description, :dynamicAddressing, :startAddress, :endAddress

    has_relationship  :location, :network
    has_relationship  :categories, multiple: true

    attr_reader :cidr

    def cidr=(addr)
      @cidr = case addr
        when String
          IPAddr.new(addr)
        when IPAddr
          addr
        else
          fail ArgumentError, 'must call with either String or IPAddr'
      end

      @startAddress = cidr.to_range.to_a.first.to_s
      @endAddress   = cidr.to_range.to_a.last.to_s
      cidr
    end
  end
end
