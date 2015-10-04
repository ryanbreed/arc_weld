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

    def identity_hash
      if identity=={}
        {}
      else
        Hash[identity.keys.map {|k| format('@%s',k.to_s)}.zip(identity.values)]
      end
    end

    def identity
      if id!=nil
        {:id => id}
      elsif externalID!=nil
        {:externalID => externalID}
      else
        {}
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
