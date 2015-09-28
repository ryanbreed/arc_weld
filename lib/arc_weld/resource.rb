module ArcWeld
  module Resource
    def self.included(klass)
      klass.class_eval do
        extend ClassMethods
      end
    end

    def hello_from_module_method
      format('hello from an instance of %s', self.class.name)
    end
    
    def resource_class_id
      self.class.class_variable_get :@@CLASS_ID
    end

    def resource_type
      self.class.send :resource_type
    end

    module ClassMethods
      def hello_from_class_method
        format('hello from class %s', self.name)
      end

      def resource_type
        name.split('::')[-1]
      end

      def toplevel
        {
          type: resource_type,
          id:   format('00100010010101%05d', class_id || 999),
          uri:  format('/All %ss/', resource_type)
        }
      end

      def class_id
        self.class_variable_get :@@CLASS_ID
      end

      def resource_root(str)
        fail ArgumentError, 'resource root must be string' unless str.is_a?(String)
        puts format('setting resource_root %s on %s', str, self.name)
        norm_str = (str.gsub(%r{\A/?},'').gsub(%r{/?\z},'').split(' ').map &:capitalize).join(' ')
        self.class_eval "@@RESOURCE_ROOT = \"/#{norm_str}/\"" 
        norm_str       
      end

      def resource_class_id(num)
        fail ArgumentError, 'class id must be Integer' unless num.is_a?(Integer)
        puts format('setting class id %d on %s', num, self.name)
        self.class_eval "@@CLASS_ID = #{num}"
        num
      end
    end
  end
end
