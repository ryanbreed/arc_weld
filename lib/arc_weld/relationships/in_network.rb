module ArcWeld
  module Relationships
    module InNetwork

      def related_in_network_resources
        (in_network.map { |net| net.ref.render }).join
      end

      def in_network_relationship
        unless in_network.nil?
          { 'inNetwork' => { 
            'list!' => related_in_network_resources } }
        end
      end

      def add_network(net)
        unless in_network.include?(net)
          in_network << net
        end
      end

      def add_networks(*nets)
        nets.each { |net| add_network(net) }
      end
    end
  end
end
