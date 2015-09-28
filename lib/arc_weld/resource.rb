module ArcWeld
  module Resource
    def self.included(klass)
      klass.class_eval '@@RESOURCE_PROPERTIES = []'
        
      klass.class_eval do
        extend ClassMethods, ArcWeld::Helpers
        
        attr_accessor :name, :id, :externalID

        def initialize(*args)
          Hash[*args].each {|k,v| self.send("#{k}=",v)}
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

    module ClassMethods
      def resource_type
        name.split('::')[-1]
      end


      def toplevel
        {
          type: resource_type,
          id:   format('01000100010001%03d', class_id),
          uri:  class_root
        }
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
