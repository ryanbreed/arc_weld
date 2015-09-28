require 'spec_helper'
describe ArcWeld::Resource do
  context 'included in class definitions' do
    it 'extends class with ArcWeld::Resource::ClassMethods' do
      expect(SpecClasses::EmptyResource).to respond_to :hello_from_class_method
    end
    
    it 'extends class instances with ArcWeld::Resource module methods' do
      er=SpecClasses::EmptyResource.new
      expect(er).to respond_to :hello_from_module_method
    end
  end
end
