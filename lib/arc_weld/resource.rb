module ArcWeld
  module Resource
    def self.included(klass)
      klass.class_eval '@@RESOURCE_PROPERTIES = []'

      klass.class_eval do
        extend ClassMethods, ArcWeld::Helpers

        attr_accessor :name, :id, :externalID, :action

        def initialize(*args)
          Hash[*args].each {|k,v| self.send("#{k}=",v)}
          @action ||= 'insert'
          yield self if block_given?
          self
        end

      end
    end

    def resource_class_id
      self.class.class_variable_get :@@CLASS_ID
    end

    def resource_type
      self.class.send :resource_type
    end

    def parent_ref
      @parent_ref ||= self.class.toplevel
    end

    def parent_ref=(containing_group)
      @parent_ref = containing_group.ref if containing_group.ref.type=='Group'
    end

    def parent_uri=(uri)
      top_root = Regexp.new(format('\A%s',self.class.toplevel.uri))
      if top_root.match(uri)
        @parent_ref = ArcWeld::Reference.new(uri: uri)
      end
    end

    def identity_hash
      if id.nil?
        {'@externalID' => externalID}
      else
        {'@id' => id}
      end
    end

    def identity
      if id.nil?
        {:externalID => externalID}
      else
        {:id => id}
      end
    end

    def property_hash
      self.class.class_properties.reduce({}) do |memo, key|
        memo[key] = self.send(key) unless self.send(key).nil?
        memo
      end
    end

    def relationship_hash
      {} # TODO: damn dirty hack
    end

    def ref_uri
      self.class.uri_join(parent_ref.uri, name) unless parent_ref.nil?
    end

    def ref
      ArcWeld::Reference.new({
        type: resource_type,
        uri:  ref_uri
        }.merge(identity)
      )
    end

    def to_h
      resource_h = {
        resource_type => {
          'childOf' => { 'list!' => parent_ref.render },
          '@name'   => name,
          '@action' => action
        }.merge(identity_hash)
         .merge(property_hash)
         .merge(relationship_hash)
      }
    end

    def render
      Gyoku.xml(to_h, key_converter: :none)
    end

    module ClassMethods
      def resource_type
        name.split('::')[-1]
      end


      def toplevel
        @top ||= ArcWeld::Reference.new(
          type: 'Group',
          id:   format('01000100010001%03d', class_id),
          uri:  class_root
        )
      end

      def class_id
        self.class_variable_get :@@CLASS_ID
      end

      def class_root
        self.class_variable_get :@@RESOURCE_ROOT
      end

      def class_properties
        self.class_variable_get :@@RESOURCE_PROPERTIES
      end

      def resource_root(str)
        fail ArgumentError, 'resource root must be string' unless str.is_a?(String)
        #puts format('setting resource_root %s on %s', str, self.name)
        norm_str = (str.gsub(%r{\A/?},'').gsub(%r{/?\z},'').split(' ').map &:capitalize).join(' ')
        self.class_eval "@@RESOURCE_ROOT = \"/#{norm_str}/\""
        norm_str
      end

      def resource_class_id(num)
        fail ArgumentError, 'class id must be Integer' unless num.is_a?(Integer)
        #puts format('setting class id %d on %s', num, self.name)
        self.class_eval "@@CLASS_ID = #{num}"
        num
      end

      def resource_property(*syms)
        syms.each do |sym|
          #puts format('defining resource property %s on %s', sym.to_s, self.name)
          register_property(sym)
        end
      end

      def register_property(sym)
        #puts format('registering property %s on %s', sym.to_s, self.name)
        unless class_properties.include?(sym)
          class_properties.push(sym)
          self.class_eval "attr_accessor :#{sym}"
        end
      end
    end
  end
end
