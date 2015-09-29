require 'spec_helper'

describe ArcWeld::Location do
  
  include_context 'basic locations'

  context 'class-level configuration' do
    describe '.toplevel' do
      let(:top) { ArcWeld::Location.toplevel }
      it 'returns a top-level resource reference' do
        expect(top).to be_a(ArcWeld::Reference)
      end
    end
    describe '.class_id' do
      it 'returns the resource type id' do
        expect(ArcWeld::Location.class_id).to eq(39)
      end
    end
    describe '.class_root' do
      it 'returns the resource base uri'do
        expect(ArcWeld::Location.class_root).to eq('/All Locations/')
      end
    end

    describe '.resource_type' do
      it 'returns the resource type as a string' do
        expect(ArcWeld::Location.resource_type).to eq('Location')
      end
    end
    describe '.class_properties' do
      it 'returns the list of resource properties as an array of symbols' do
        expect(ArcWeld::Location.class_properties).to eq([:countryCode, :city, :countryName, :description, :latitude, :longitude, :postalCode, :regionCode])
      end
    end
  end

  context 'initializing instances' do
    describe '.initialize' do
      it 'initializes from keyword args' do
        expect(location.name).to                eq('spec location')
        expect(location.externalID).to          eq('spec_location_000')
        expect(location.description).to         eq('Location resource under test')
      end
    end
  end
end
