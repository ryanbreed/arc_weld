module ArcWeld
  module Relationships
    module InZone
      def in_zone_relationship
        unless in_zone.nil?
          { 'inZone' => { 'list!' => in_zone.ref.render } }
        end
      end

      def auto_zone(*zones)
        my_zone = zones.find {|z| z.contains?(self.address)}
        self.set_zone(my_zone) unless my_zone.nil?
      end

      def set_zone(tgt_zone)
        if tgt_zone.contains?(address)
          #if self.staticAddressing.nil?
            self.staticAddressing = tgt_zone.staticAddressing
          #end
          #if self.has_location.nil? && (tgt_zone.has_location!=nil)
            self.has_location = tgt_zone.has_location
            self.in_network = tgt_zone.in_network
            asset_group_uri = tgt_zone.ref_uri.gsub('All Zones', 'All Assets')
            self.parent_ref = ArcWeld::Reference.new(
              uri: asset_group_uri,
              externalID: OpenSSL::Digest::MD5.base64digest(asset_group_uri),
              type: 'Group'
            )
          #end
          @in_zone = tgt_zone
        end
      end

      def in_zone=(zone)
        self.set_zone(zone)
      end
    end
  end
end
