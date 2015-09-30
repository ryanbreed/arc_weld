module ArcWeld
  module Relationships
    module HasChild
      def related_has_child_references
        has_child.map {|res| res.ref.render }.join
      end

      def has_child_relationship
        {'hasChild' => { 'list!' => related_has_child_references }}
      end

      def add_child(child)
        unless has_child.include?(child)
          if containedResourceType.nil?
            self.containedResourceType=child.resource_class_id
          end

          if parent_ref.nil?
            self.parent_ref=child.class.toplevel
          end

          if child.resource_class_id != self.containedResourceType
            fail RuntimeError, 'child resource does not match contained types'
          end
          self.has_child.push(child)
          child.parent_ref=self.ref
        end
      end

      def add_children(*resources)
        resources.each {|res| add_child(res) }
      end

      def contains_resource_type
        unless self.has_child.empty?
          has_child.first.resource_type
        end
      end
    end
  end
end
