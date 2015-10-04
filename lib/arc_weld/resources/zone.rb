module ArcWeld
  class Zone
    include ArcWeld::Resource
    include ArcWeld::Relationship

    resource_class_id 29
    resource_root     '/All Zones/'
    resource_property :description, :dynamicAddressing, :startAddress, :endAddress

    has_relationship  :has_location
    has_relationship  :in_network, :in_category, multiple: true

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
          nil
      end
      if ([comp, startAddress, endAddress].any? &:nil?)
        false
      else
        start_ip <= comp && end_ip >= comp
      end
    end

    def staticAddressing
      case self.dynamicAddressing
        when 'true', true
          'false'
        when 'false', false
          'true'
        else
          nil
      end
    end
  end
end
