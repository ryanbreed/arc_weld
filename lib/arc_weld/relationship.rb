require 'arc_weld/relationship/alternate_interfaces'
require 'arc_weld/relationship/categories'

module ArcWeld
  module Relationship

    def self.included(klass)
      klass.class_eval '@@RELATIONSHIPS = []'
      klass.class_eval do
        extend ClassMethods
      end

    end

    def relationship_types
      self.class.class_variable_get :@@RELATIONSHIPS
    end

    def relationship_hash
      relationship_types.reduce({}) do |memo, key|
        meth = format('%s_relationship',key)
        if self.respond_to?(meth)
          memo.merge!(self.send(meth)) unless self.send(meth).nil?
        end
        memo
      end
    end

    module ClassMethods
      def has_relationship(*args)
        #puts format('defining relationship on %s', self.name)
        options=case args[-1]
          when Hash
            args.pop
          else
            Hash.new(false)
        end

        args.each do |sym|
          register_relationship(sym,options[:multiple])
        end
      end
      
      def class_relationship_types
        class_variable_get :@@RELATIONSHIPS
      end

      def register_relationship(name, multiple=false)
        unless class_relationship_types.include?(name)
          class_relationship_types << name

          if multiple
            self.class_eval do
              define_method("#{name}") do 
                val = self.instance_variable_get("@#{name}")
                if val.nil? 
                  self.instance_variable_set("@#{name}",[])
                end
                self.instance_variable_get("@#{name}")
              end
            end
          else
            self.class_eval do
              define_method("#{name}") do 
                self.instance_variable_get("@#{name}")
              end
            end
          end

          self.class_eval do
            define_method("#{name}=") do |val|
              self.instance_variable_set("@#{name}",val)
            end
          end

          if ArcWeld::Relationships.const_defined? constantize(name)
            self.class_eval "include ArcWeld::Relationships::#{constantize(name)}"
          end
        end
      end
    end
  end
end
