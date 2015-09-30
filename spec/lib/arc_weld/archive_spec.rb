require 'spec_helper'

describe ArcWeld::Archive do
  include_context 'basic assets'
  include_context 'basic zones'
  include_context 'basic locations'
  include_context 'basic customers'
  include_context 'basic networks'
  include_context 'basic groups'

  let(:archive_ctime) { Time.at(1440000000) }
  let(:empty_archive) { ArcWeld::Archive.new( createTime: archive_ctime ) }

  describe '#archive_creation_parameters' do
    it 'renders without an include list for archives with no resources'
    it 'renders an include list for archives with resources'
  end

  describe '#resource_content' do
    it 'renders single resources'
    it 'renders multiple resources' 
  end
  
  describe '#render' do
    it 'renders archives with no resources to the base template'
  end

  describe '#dtd' do
    it 'renders the default dtd path if not explicitly set'
    it 'can set arbitrary path locations' 
  end
  context 'adding resources' do
    describe '#add' do
      it 'adds single resources to the @resources instance attribute' 
      it 'adds multiple resources to the @resources instance attribute'
    end
    describe '#include_list' do
      it 'renders group resource references in the include list'
      it 'renders multiple resource type references in the include list'
    end
  end

  context 'writing XML files' do
    let(:spec_out) { 'tmp/spec_xmlgen.xml' }
    let(:spec_out_fh) { File.open(spec_out,'w') }
    let(:spec_xml) { File.read('spec/fixtures/spec.xml') }

    after(:example) do
      if File.exist?(spec_out)
        File.unlink(spec_out)
      end
    end
    
  end
end  