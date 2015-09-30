module ArcWeld
  module Relationships
    module HasLocation
      def has_location_relationship
        unless has_location.nil?
          { 'hasLocation' => { 'list!' => has_location.ref.render } }
        end
      end
      def has_location=(location)
        if @has_location.nil?
          @has_location=location
          location.add_location_resource(self)
        elsif @has_location==location
          true
        else
          fail RuntimeError, 'resource already has location assignment'
        end
      end
    end
  end
end
