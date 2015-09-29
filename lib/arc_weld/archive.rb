module ArcWeld
  class Archive
    attr_accessor :resources, :createTime, :dtd_location

    BUILD_VERSION = '6.5.1.1952.1'
    BUILD_TIME    = '3-6-2015_17:2:26'
    TIME_FORMAT   = '%m-%d-%Y_%H:%M:%S'

    PARSE_DEFAULT  = Nokogiri::XML::ParseOptions::DEFAULT_XML
    PARSE_VALIDATE = Nokogiri::XML::ParseOptions::DEFAULT_XML | Nokogiri::XML::ParseOptions::DTDLOAD

    ARCHIVE_DTD   = "../../schema/xml/archive/arcsight-archive.dtd"

    def initialize(*args)
      Hash[*args].each {|k,v| self.send(format('%s=',k),v)}
      @resources    ||= []
      @createTime   ||= Time.new
      @dtd_location ||= ARCHIVE_DTD
      self
    end

    def include_list
      resources.map {|g| g.ref.render }.join('')
    end

    def add_item(item)
      resources.push(item) unless resource.include?(item)
    end
    
    def add(*items)
      items.each { |item| add_item(item) }      
    end

    def dtd(location=ARCHIVE_DTD)
      format('<!DOCTYPE archive SYSTEM "%s">', dtd_location)
    end

    def archive_creation_parameters
      acp = {
        ArchiveCreationParameters: {
          :action    => 'insert',
          'excludeReferenceIDs/' => '',
          :format    => 'default',
          'formatRoot/' => ''
        }
      }

      if resources.empty?
        acp[:ArchiveCreationParameters]['include/'] = ''
      else
        acp[:ArchiveCreationParameters][:include] = { :list! => include_list }
      end

      Gyoku.xml(acp, {key_converter: :none})
    end

    def create_time
      @createTime.strftime(TIME_FORMAT)
    end

    def resource_content
      resources.map {|res| res.render }.join('')
    end

    def to_h
      archive_h = {
        :archive! => archive_creation_parameters + resource_content,
        :attributes! => {
          :archive! => {
            :buildVersion => BUILD_VERSION,
            :buildTime    => BUILD_TIME,
            :createTime   => create_time
          }
        }
      }
    end

    def render
      Gyoku.xml(to_h, {key_converter: :none} )
    end

    def xml(options=PARSE_DEFAULT)
      Nokogiri.XML(dtd + render, nil, 'UTF-8', options)
    end

  end
end