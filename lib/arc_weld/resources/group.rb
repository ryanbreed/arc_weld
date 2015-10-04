module ArcWeld
  class Group
    include ArcWeld::Resource
    include ArcWeld::Relationship

    resource_property :containedResourceType, :description, :memberReferencePage
    has_relationship  :has_child, :in_category, :in_network, :has_customer, multiple: true

    def self.class_id
      fail TypeError, 'no group resource class_id'
    end

    def self.class_root
      fail TypeError, 'no group resource class_root'
    end

    def resource_class_id
      fail TypeError, 'no group resource class_id'
    end

    def self.toplevel
      fail TypeError, 'no top-level group resource reference'
    end

    def parent_ref
      @parent_ref
    end
  end
end
