module ArcWeld
  module Relationships
    module InZone
      def in_zone_relationship
        unless in_zone.nil?
          {
            'inZone' => { 'list!' => in_zone.ref.render }
          }
        end
      end
      def auto_zone(*zones)
        my_zone = zones.select {|z| z.contains?(address)}.first
        in_zone = my_zone unless (my_zone.empty? || my_zone.nil?)
      end
      def in_zone=(tgt_zone)
        if tgt_zone.contains?(address)
          @in_zone=tgt_zone
        else
          fail RuntimeError, 
               format('target zone %s-%s does not contain asset %s address %s',
                      tgt_zone.startAddress,
                      tgt_zone.endAddress,
                      name,
                      address)
        end
      end
    end
  end
end
