module ArcWeld
  module Relationships
    module AlternateInterfaces
      def add_interfaces(*assets)
        assets.each do |asset|
          unless alternate_interfaces.include?(asset)
            alternate_interfaces << asset
          end
          unless asset.alternate_interfaces.include?(self)
            asset.alternate_interfaces << self
          end
        end
      end
      def alternate_interfaces_relationship
        {
          :hasAlternateInterface => {
            :list! => (alternate_interfaces.map {|a| a.ref.render}).join
          },
          :alternateInterfaceOf => {
            :list! => (alternate_interfaces.map {|a| a.ref.render}).join
          }
        }
      end
    end
  end
end
