$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
#$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__))
require 'arc_weld'

begin
  require 'spec_class_definitions'
  require 'shared_instances'
rescue NoMethodError
  puts 'not done yet'
end