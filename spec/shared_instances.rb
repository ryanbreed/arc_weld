require 'spec_helper'

shared_context 'basic assets' do
  let(:asset) {ArcWeld::Asset.new(
    name:        '192.168.1.1 - asset01.local',
    address:     '192.168.1.1',
    macAddress:  'be:ef:be:ef:be:ef',
    hostname:    'asset01.local',
    description: 'spec asset 1',
    externalID:  'spec_asset_01'
  )}

  let(:asset2) {ArcWeld::Asset.new(
    name:        '192.168.1.2 - asset02.local',
    address:     '192.168.1.2',
    macAddress:  'be:ef:be:ef:be:ef',
    hostname:    'asset02.local',
    description: 'spec asset 2',
    externalID:  'spec_asset_02'
  )}

  let(:asset3) {ArcWeld::Asset.new(
    name:        '192.168.1.3 - asset03.local',
    address:     '192.168.1.3',
    macAddress:  'be:ef:be:ef:be:ef',
    hostname:    'asset03.local',
    description: 'spec asset 3',
    externalID:  'spec_asset_03'
  )}

  let(:asset21) {ArcWeld::Asset.new(
    name:        '192.168.2.1 - asset21.local',
    address:     '192.168.2.1',
    macAddress:  'be:ef:be:ef:be:ef',
    hostname:    'asset01.local',
    description: 'spec asset 1',
    externalID:  'spec_asset_01'
  )}

  let(:asset22) {ArcWeld::Asset.new(
    name:        '192.168.2.2 - asset22.local',
    address:     '192.168.2.2',
    macAddress:  'be:ef:be:ef:be:ef',
    hostname:    'asset22.local',
    description: 'spec asset 22',
    externalID:  'spec_asset_22'
  )}

  let(:asset23) {ArcWeld::Asset.new(
    name:        '192.168.2.3 - asset23.local',
    address:     '192.168.2.3',
    macAddress:  'be:ef:be:ef:be:ef',
    hostname:    'asset23.local',
    description: 'spec asset 23',
    externalID:  'spec_asset_23'
  )}
end

shared_context 'basic zones' do
  let(:zone) { ArcWeld::Zone.new(
    name:              'spec zone - 192.168.1.0-24',
    cidr:              '192.168.1.0/24',
    description:       'spec zone',
    externalID:        'spec_zone_001',
    dynamicAddressing: 'true'
  )}

  let(:zone2) { ArcWeld::Zone.new(
    name:              'spec zone 2 - 192.168.2.0-24',
    cidr:              '192.168.2.0/24',
    description:       'spec zone',
    externalID:        'spec_zone_002',
    dynamicAddressing: 'false'
  )}

  let(:zone3) { ArcWeld::Zone.new(
    name:              'spec zone 3 - 192.168.3.0-24',
    cidr:              '192.168.3.0/24',
    description:       'spec zone',
    externalID:        'spec_zone_003',
    dynamicAddressing: 'false'
  )}
end

shared_context 'basic locations' do
  let(:location) { ArcWeld::Location.new(
    name:        'spec location',
    description: 'Location resource under test',
    countryCode: 'US',
    city:        'Austin',
    latitude:    '30.3077609',
    longitude:   '-97.7534014',
    countryName: 'United States',
    regionCode:  'TX',
    externalID:  'spec_location_001'
  )}

  let(:location2) { ArcWeld::Location.new(
    name:        'spec location 2',
    description: 'really the same location',
    countryCode: 'US',
    city:        'Austin',
    latitude:    '30.3077609',
    longitude:   '-97.7534014',
    countryName: 'United States',
    regionCode:  'TX',
    externalID:  'spec_location_002'
  )}
end

shared_context 'basic categories' do
  let(:category) { ArcWeld::AssetCategory.new(
    name:                'spec category 1',
    description:         'category for resources under test',
    externalID:          'spec_category_001',
    memberReferencePage: 'https://signed.bad.horse'
  )}

  let(:category2) { ArcWeld::AssetCategory.new(
    name:                'spec category 2',
    description:         'contained category',
    externalID:          'spec_category_002',
    memberReferencePage: 'http://bad.horse'
  )}

  let(:category3) {ArcWeld::AssetCategory.new(
    name:                'spec category 3',
    description:         'container category',
    externalID:          'spec_category_003',
    memberReferencePage: 'http://www.grumpycats.com'
  )}
end

shared_context 'basic customers' do
  let(:customer) { ArcWeld::Customer.new(
    name:           'spec customer',
    externalID:     'spec_customer_001',
    streetAddress1: 'address line 1',
    streetAddress2: 'address line 2',
    addressState:   'Texas',
    country:        'United States'
  )}
  let(:customer2) { ArcWeld::Customer.new(
    name:           'spec customer 2',
    externalID:     'spec_customer_002',
    streetAddress1: 'address line 1',
    streetAddress2: 'address line 2',
    addressState:   'Texas',
    country:        'United States'
  )}
end

shared_context 'basic networks' do
  let(:network) { ArcWeld::Network.new(
    name:        'spec network',
    externalID:  'spec_network_001',
    description: 'spec network'
  )}

  let(:network2) { ArcWeld::Network.new(
    name:        'spec network 2',
    externalID:  'spec_network_002',
    description: 'spec network 2'
  )}
end

shared_context 'basic groups' do
  let(:group) { ArcWeld::Group.new(
    name:                'spec group 1',
    description:         'group for resources under test',
    externalID:          'spec_group_001',
    memberReferencePage: 'https://signed.bad.horse'
  )}

  let(:group2) { ArcWeld::Group.new(
    name:                'spec group 2',
    description:         'contained group',
    externalID:          'spec_group_002',
    memberReferencePage: 'http://bad.horse'
  )}

  let(:group3) {ArcWeld::Group.new(
    name:                'spec group 3',
    description:         'container group',
    externalID:          'spec_group_003',
    memberReferencePage: 'http://www.grumpycats.com'
  )}
end
