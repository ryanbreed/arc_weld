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
    end
  end
end
