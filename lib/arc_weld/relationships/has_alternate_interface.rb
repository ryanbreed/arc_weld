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
      def related_has_alternate_interface_references
        (has_alternate_interface.map {|a| a.ref.render}).join
      end
      def has_alternate_interface_relationship
        unless has_alternate_interface.empty?
          { 'hasAlternateInterface' => {
              'list!' => related_has_alternate_interface_references},
            'alternateInterfaceOf' => {
              'list!' => related_has_alternate_interface_references} }
        end
      end
    end
  end
end
