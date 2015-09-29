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

    def start_ip
      IPAddr.new(startAddress)
    end

    def end_ip
      IPAddr.new(endAddress)
    end

    def contains?(addr)
      comp = case addr
        when String
          IPAddr.new(addr)
        when IPAddr
          addr
        else
          fail ArgumentError, 'can only check containment for IP-like things'
      end

      start_ip <= comp && end_ip >= comp
    end
  end
end
