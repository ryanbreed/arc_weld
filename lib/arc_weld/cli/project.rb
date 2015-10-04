module ArcWeld
  module Cli
    class Project
      include ArcWeld::Helpers
      attr_accessor :name, :input_dir, :output_dir, :resource_driver,
        :resource_root, :resource_inputs, :relationships, :base_model

      def initialize(config)
        config.each {|k,v| self.send(format('%s=',k),v)}
        self
      end

      def resource_class_for(resource_type)
        ArcWeld.const_get(constantize(resource_type))
      end

      def resource_input_path(resource_type)
        File.join(self.input_dir, resource_inputs.fetch(resource_type))
      end

      def resource_reader(resource_type)
        klass = ArcWeld::Cli::ResourceReaders.const_get(constantize(resource_driver))
        klass.new( path:         resource_input_path(resource_type),
                   target_class: resource_class_for(resource_type) )
      end

      def reader
        @readers ||= Hash[
          resource_inputs.keys.map { |type| [type, resource_reader(type)]}
        ]
      end

      def resources
        @resources ||= Hash.new {|h,k| h[k]=Array.new }
      end

      def archive_resources(resource_type)
        archive.resources.select {|r| r.resource_type == constantize(resource_type)}
      end

      def archive
        @archive ||= Archive.new
      end

      def load_resources
        reader.each do |type, type_reader|
          res=type_reader.to_a
          resources[type].push(*res)
        end
      end

      def resource_group(type)
        klass = ArcWeld.const_get(constantize(type))
        group_name = resource_root[type]
        ArcWeld::Group.new(
          name:                  group_name,
          externalID:            format('weld_%s_root', type),
          description:           format('ArcWeld root %s group',
                                        constantize(type)),
          containedResourceType: klass.class_id,
          parent_ref:            klass.toplevel
        )
      end

      def resource_roots
        @roots ||= Hash[
          resource_root.map do |type, group_name|
            grp = resource_group(type)
            resources['group'].push(grp)
            [type, grp ]
          end
        ]
      end

      def zone_assets
        resources['asset'].each do |asset|
          asset.auto_zone(*resources['zone'])
        end
      end

      def relate_model
        relationships.each do |rel|
          klass = ArcWeld::Cli::RelationReaders.const_get(constantize(rel['driver']))
          rel_reader = klass.new(
            path:               File.join(input_dir,rel['file']),
            relationship_type: rel['type'] )
          sources = resources[rel_reader.src_type]
          dests   = resources[rel_reader.dst_type]
          rel_reader.relate(sources,dests)
        end
      end

      def group_resources
        resource_roots['zone'].add_children(*resources['zone'])

        zone_assets

        unzoned = resources['asset'].select {|a| a.in_zone.nil?}
        resource_roots['asset'].add_children(*unzoned)

        %w{ network customer location asset_category }.each do |type|
          resource_roots[type].add_children(*resources[type])
        end
      end

      def generate_archive
        resource_roots
        load_resources
        group_resources
        relate_model
        archive.add(*resources.values.flatten)
        archive
      end
    end
  end
end
