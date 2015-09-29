module ArcWeld
  module Relationships
    module HasAlternateInterface
      def add_interfaces(*assets)
        assets.each do |asset|
          unless has_alternate_interface.include?(asset)
            has_alternate_interface << asset
          end
          unless asset.has_alternate_interface.include?(self)
            asset.has_alternate_interface << self
          end
        end
      end
      def has_alternate_interface_relationship
        unless has_alternate_interface.empty?
          {
            'hasAlternateInterface' => {
              'list!' => (has_alternate_interface.map {|a| a.ref.render}).join
            },
            'alternateInterfaceOf' => {
              'list!' => (has_alternate_interface.map {|a| a.ref.render}).join
            }
          }
        end
      end
    end
  end
end
