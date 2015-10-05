require 'arc_weld'
require 'arc_weld/cli/project'
require 'arc_weld/cli/readers/relation_csv'
require 'arc_weld/cli/readers/relation_csv_category_uri'
require 'arc_weld/cli/readers/resource_csv'
require 'openssl'
require 'json'
module ArcWeld
  class WeldCli < Thor

   include Thor::Actions
    def self.source_root
      @source_root ||= File.join( File.dirname( File.expand_path(__FILE__) ),
                                  'templates')
    end

    class_option :config,
      type: :string,
      default: 'weld.json',
      desc: 'config file'

    desc 'new PROJECT_NAME', 'generate new project'
    option :dir,
      type: :string,
      default: Dir.pwd,
      desc: 'create project directory here'
    option :driver,
      type: :string,
      default: 'csv',
      desc: 'driver for reading resources and relations'
    def new(name)
      self.destination_root = options[:dir]
      @config = options.merge(name: name)
      directory(format('project-%s',options[:driver]),name)
    end

    desc 'generate FILENAME', 'render entire model in FILENAME'
    def generate(filename='model.xml')
      config = JSON.parse(File.read(options[:config]))
      project = ArcWeld::Cli::Project.new(config)
      outfile = File.join(project.output_dir, filename)
      archive = project.generate_archive
      File.open(outfile,'w') {|f| f.puts archive.xml.to_s }
    end
  end
end
