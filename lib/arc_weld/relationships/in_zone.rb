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

      def parent_ref_from_zone(zone)
        unless zone.parent_ref == ArcWeld::Zone.toplevel
          asset_group_uri = tgt_zone.ref_uri.gsub('All Zones', 'All Assets')
          ArcWeld::Reference.new(
            uri: asset_group_uri,
            externalID: OpenSSL::Digest::MD5.base64digest(asset_group_uri),
            type: 'Group'
          )
        end
      end
      def set_zone(tgt_zone)
        if tgt_zone.contains?(address)
          self.staticAddressing = tgt_zone.staticAddressing
          self.has_location = tgt_zone.has_location
          self.in_network = tgt_zone.in_network
          tgt_ref = parent_ref_from_zone(tgt_zone)
          self.parent_ref =  tgt_ref unless tgt_ref.nil?
          @in_zone = tgt_zone
        end
      end

      def in_zone=(zone)
        self.set_zone(zone)
      end
    end
  end
end
