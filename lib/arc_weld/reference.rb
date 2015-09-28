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

    def externalID
      @externalID ||= name
    end

    def ==(other)
      [:type, :uri, :id, :externalID].all? do |attr|
        self.send(attr) == other.send(attr)
      end
    end

    def to_h
      ref_h = {
        'ref/' => '',
        :attributes! => {
          'ref/' => {
          :type => type,
          :uri  => uri
        }}
      }

      if id.nil?
        ref_h[:attributes!]['ref/'][:externalID] = externalID
      else
        ref_h[:attributes!]['ref/'][:id] = id
      end

      ref_h
    end

    def render
      Gyoku.xml(to_h, key_converter: :none)
    end
  end
end