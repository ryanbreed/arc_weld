module ArcWeld
  module Relationships
    module HasLocation
      def has_location_relationship
        unless has_location.nil?
          { 'hasLocation' => { 'list!' => has_location.ref.render } }
        end
      end
      def has_location=(location)
        
        location.add_location_resource(self) unless location.nil?
        @has_location=location
      end
    end
  end
end
