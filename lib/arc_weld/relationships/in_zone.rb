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
          if self.staticAddressing.nil?
            self.staticAddressing = tgt_zone.staticAddressing
          end
          @in_zone = tgt_zone
        end
      end

      def in_zone=(zone)
        self.set_zone(zone)
      end
    end
  end
end
