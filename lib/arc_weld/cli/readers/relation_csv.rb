module ArcWeld
  module Cli
    module RelationReaders
      class Csv
        include ArcWeld::Helpers
        attr_accessor :path, :relationship_type,
                      :src_select, :dst_select,
                      :src_class,  :dst_class

        attr_reader   :csv, :keys, :src_type, :dst_type

        def initialize(*args)
          Hash[*args].each {|k,v| self.send(format('%s=',k),v)}
          @csv = CSV.open(path)
          @keys = csv.readline
          @src_type, @src_select, @dst_type, @dst_select = keys.flat_map do |k|
             k.split(':')
          end
          @src_class=ArcWeld.const_get(constantize(src_type))
          @dst_class=ArcWeld.const_get(constantize(dst_type))
          self
        end

        def relate(sources,destinations)
          csv.each do |selected_src, selected_dst|
            src_instance=sources.find {|s| s.send(src_select)==selected_src}
            dst_instance=destinations.find {|s| s.send(dst_select)==selected_dst}
            if (src_instance.nil? || dst_instance.nil?)
              STDERR.puts format('could not %s %s/%s',
                                 relationship_type,
                                 selected_src,
                                 selected_dst)
            else
               src_instance.send(relationship_type,dst_instance)
            end
          end
        end
      end
    end
  end
end
