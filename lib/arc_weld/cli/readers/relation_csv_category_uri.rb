module ArcWeld
  module Cli
    module RelationReaders
      class CsvCategoryUri
        include ArcWeld::Helpers
        attr_accessor :path, :src_select, :src_class, :relationship_type

        attr_accessor :inputs
        attr_reader   :csv, :keys, :src_type

        def initialize(*args)
          Hash[*args].each {|k,v| self.send(format('%s=',k),v)}
          @csv = CSV.open(path)
          @keys = csv.readline
          @src_type, @src_select, *unused= keys.flat_map do |k|
             k.split(':')
          end
          @src_class=ArcWeld.const_get(constantize(src_type))
          self
        end

        def sources(inputs)
          inputs[src_type]
        end

        def destinations(inputs)
          []
        end

        def relate(inputs)
          csv.each do |selected_src, category_uri|
            src_instance=sources(inputs).find {|s| s.send(src_select)==selected_src}

            if (src_instance.nil?)
              STDERR.puts format('could not add category uri %s to %s (resource nil)',
                                 category_uri,
                                 selected_src)
              next
            end
            if ac_resource = inputs['asset_category'].find {|ac| ac.ref_uri==category_uri}
              src_instance.add_category(ac_resource)
            else
              src_instance.send(relationship_type,category_uri)
            end
          end
        end
      end
    end
  end
end
