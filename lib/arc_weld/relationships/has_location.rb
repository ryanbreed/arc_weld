module ArcWeld
  module Relationships
    module HasLocation
      def has_location_relationship
        unless has_location.nil?
          {
            'hasLocation' => { 'list!' => has_location.ref.render }
          }
        end
      end
    end
  end
end
