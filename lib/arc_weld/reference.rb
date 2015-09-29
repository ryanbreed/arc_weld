module ArcWeld
  class Reference
    attr_accessor :type, :uri, :id, :externalID

    def initialize(*args)
      Hash[*args].each {|k,v| self.send(format('%s=',k),v)}
      @type ||= 'Group'
    end

    def ref
      self
    end

    def ==(other)
      [:type, :uri, :id, :externalID].all? do |attr|
        self.send(attr) == other.send(attr)
      end
    end

    def identity
      if id.nil?
        {:externalID => externalID}
      else
        {:id => id}
      end
    end    

    def identity_hash
      if id.nil?
        {:@externalID => externalID}
      else
        {:@id => id}
      end
    end

    def to_h
     {
        'ref/' => {
          :@type => type,
          :@uri   => uri
        }.merge(identity_hash)
      }
    end

    def render
      Gyoku.xml(to_h, key_converter: :none)
    end
  end
end