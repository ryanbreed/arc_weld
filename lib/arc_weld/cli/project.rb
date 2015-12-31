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

      def input_file(filename)
        File.join(self.input_dir, filename)
      end

      def resource_reader(resource_type,filename)
        klass = ArcWeld::Cli::ResourceReaders.const_get(constantize(resource_driver))
        klass.new( path:         input_file(filename),
                   target_class: resource_class_for(resource_type) )
      end

      def reader
        @readers ||= Hash[
          resource_inputs.map  do |resource_type,*filenames| 
            resource_type_readers = filenames.flatten.map {|filename| resource_reader(resource_type,filename)}
            [resource_type, resource_type_readers]
          end
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
        reader.each do |type, type_readers|
          res=type_readers.flat_map &:to_a
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

      def assign_model_relations
        relationships.each do |rel|
          klass = ArcWeld::Cli::RelationReaders.const_get(constantize(rel['driver']))
          rel_reader = klass.new(
            path:              File.join(input_dir,rel['file']),
            relationship_type: rel['type']
           )

          rel_reader.relate(resources)
        end
      end

      def assign_resource_groups
        unzoned = resources['asset'].select {|a| a.in_zone.nil?}
        resource_roots['asset'].add_children(*unzoned)

        %w{ network customer location asset_category zone }.each do |type|
          unrooted = resources[type].select {|instance| instance.parent_ref==instance.class.toplevel }
          resource_roots[type].add_children(*unrooted)
        end
      end

      def generate_archive
        resource_roots
        load_resources
        zone_assets
        assign_resource_groups
        assign_model_relations
        archive.add(*resources.values.flatten)
        archive
      end
    end
  end
end
