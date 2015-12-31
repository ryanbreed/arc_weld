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
    it 'renders without an include list for archives with no resources' do
      expect(empty_archive.archive_creation_parameters).to eq("<ArchiveCreationParameters><action>insert</action><excludeReferenceIDs/><format>default</format><formatRoot/><include/></ArchiveCreationParameters>")
    end
    it 'renders an include list for archives with resources' do
      empty_archive.add(asset)
      expect(empty_archive.archive_creation_parameters).to match(asset.ref.render)
    end
  end

  describe '#resource_content' do
    it 'renders single resources' do
      empty_archive.add(asset)
      expect(empty_archive.resource_content).to eq(asset.render)
    end
    it 'renders multiple resources' do
      empty_archive.add(asset,asset2)
      expect(empty_archive.resource_content).to eq(asset.render + asset2.render)
    end
  end
  
  describe '#render' do
    it 'renders archives with no resources to the base template' do
      expect(empty_archive.render).to match("<include/></ArchiveCreationParameters></archive>")
    end
  end

  describe '#dtd' do
    it 'renders the default dtd path if not explicitly set' do
      expect(empty_archive.dtd).to eq("<!DOCTYPE archive SYSTEM \"../../schema/xml/archive/arcsight-archive.dtd\">")
    end
    it 'can set arbitrary path locations' do
      empty_archive.dtd_location='/somepath/to/arcsight-archive.dtd'
      expect(empty_archive.dtd).to eq('<!DOCTYPE archive SYSTEM "/somepath/to/arcsight-archive.dtd">')
    end

  end
  context 'adding resources' do
    describe '#add' do
      it 'adds single resources to the @resources instance attribute' do
        empty_archive.add(asset)
        expect(empty_archive.resources).to eq([asset])
      end
      it 'adds multiple resources to the @resources instance attribute' do
        empty_archive.add(asset,asset2)
        expect(empty_archive.resources).to eq([asset,asset2])
      end
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