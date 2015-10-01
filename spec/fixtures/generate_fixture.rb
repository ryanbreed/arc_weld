def reader 
  @resource_readers ||= {
    :asset =>  ArcWeld::Readers::Csv.new(file_path: 'spec/fixtures/assets.csv', target_class: ArcWeld::Asset),

    :category => ArcWeld::Readers::Csv.new(file_path: 'spec/fixtures/categories.csv', target_class: ArcWeld::AssetCategory),

    :customer => ArcWeld::Readers::Csv.new(
                   file_path:    'spec/fixtures/customers.csv', 
                   target_class: ArcWeld::Customer),

    :group => ArcWeld::Readers::Csv.new(
                   file_path:    'spec/fixtures/groups.csv', 
                   target_class: ArcWeld::Group),

    :location => ArcWeld::Readers::Csv.new(
                   file_path:    'spec/fixtures/locations.csv', 
                   target_class: ArcWeld::Location),

    :network => ArcWeld::Readers::Csv.new(
                   file_path:    'spec/fixtures/networks.csv', 
                   target_class: ArcWeld::Network),

    :zone => ArcWeld::Readers::Csv.new(
                   file_path:    'spec/fixtures/zones_cidr.csv', 
                   target_class: ArcWeld::Zone)
  }
end

def resources
  @resources ||= Hash.new {|h,k| h[k]=Array.new}
end

def resource(key)
  reader.fetch(key).to_a(rewind: true)
end

def empty_archive
  ArcWeld::Archive.new
end

def archive
  @accumulator_archive ||= empty_archive
end

def populate_resources
  @resources=nil
  [:asset,:category,:customer,:location,:network,:zone, :group].each do |r| 
    resources[r].push(*resource(r))
  end
end

def resource_group(key)
  resources[:group].select {|g| g.name.match(Regexp.new(format('^%s',key.to_s)))}
end

def zone_assets
  resources[:asset].each {|a| a.auto_zone(*resources[:zone])}
end

def network_zones
  net=resources[:network].cycle
  resources[:zone].each {|z| z.add_network(net.next)}
end

def locate_zones
  loc=resources[:location].cycle
  resources[:zone].each {|z| z.has_location=loc.next }
end

def network_customers
  net=resources[:network].cycle
  resources[:customer].each {|c| c.add_customer_resource(net.next)}
end



def group_zones
  zg=ArcWeld::Group.new(
    name: 'fixture zones',
    externalID: 'fixture_group_zones',
    containedResourceType: 29,
    parent_ref: ArcWeld::Zone.toplevel
  )
  archive.add(zg)
  zgs=resource_group(:zone)
  zg.add_children(*zgs)
  enum=zgs.cycle
  resources[:zone].each {|z| enum.next.add_child(z)}
end

def group_networks
  ng = ArcWeld::Group.new(
    name: 'fixture networks',
    externalID: 'fixture_group_networks',
    containedResourceType: ArcWeld::Network.class_id,
    parent_ref: ArcWeld::Network.toplevel
  )
  ngs = resource_group(:network)
  ng.add_children(*ngs)
  archive.add(ng)
  enum=ngs.cycle
  resources[:network].each {|n| enum.next.add_child(n)}
end

def group_customers
  cg = ArcWeld::Group.new(
    name:                  'fixture customers',
    externalID:            'fixture_group_customers',
    containedResourceType: ArcWeld::Customer.class_id,
    parent_ref:            ArcWeld::Customer.toplevel
  )
  cgs = resource_group(:customer)
  cg.add_children(*cgs)
  archive.add(cg)
  enum=cgs.cycle
  resources[:customer].each {|c| enum.next.add_child(c)}
end

def group_locations
  lg = ArcWeld::Group.new(
    name:                  'fixture locations',
    externalID:            'fixture_group_locations',
    containedResourceType: ArcWeld::Location.class_id,
    parent_ref:            ArcWeld::Location.toplevel
  )
  lgs = resource_group(:location)
  lg.add_children(*lgs)
  archive.add(lg)
  enum=lgs.cycle
  resources[:location].each {|l| enum.next.add_child(l)}
end

def group_assets
  zag = ArcWeld::Group.new(
    name:                  'fixture zones',
    externalID:            'fixture_zoned_assets',
    containedResourceType: ArcWeld::Asset.class_id,
    parent_ref:            ArcWeld::Asset.toplevel
  )
  g = ArcWeld::Group.new(
    name:                  'fixture assets',
    externalID:            'fixture_group_assets',
    containedResourceType: ArcWeld::Asset.class_id,
    parent_ref:            ArcWeld::Asset.toplevel
  )
  archive.add(g,zag)
  unzoned=resources[:asset].select {|a| a.in_zone.nil?}
  g.add_children(*unzoned)
end

def group_categories
  g = ArcWeld::Group.new(
    name:                  'fixture categories',
    externalID:            'fixture_group_categories',
    containedResourceType: ArcWeld::AssetCategory.class_id,
    parent_ref:            ArcWeld::AssetCategory.toplevel
  )
  archive.add(g)
  g.add_children(*resources[:category])
end

def categorize_assets
  acs=CSV.open('spec/fixtures/asset_categories.csv')
  acs_keys = acs.readline.map {|e| e.split(':')}
  acs.each do |asset_eid,category_eid|
    asset=resources[:asset].find {|a| a.externalID == asset_eid}
    category=resources[:category].find {|c| c.externalID == category_eid}
    asset.add_category(category)
  end
end

def categorize_zones
  cs=CSV.open('spec/fixtures/zone_categories.csv')
  cs_keys = cs.readline.map {|e| e.split(':')}
  cs.each do |zone_eid,category_eid|
    zone=resources[:zone].find {|z| z.externalID == zone_eid}
    category=resources[:category].find {|c| c.externalID == category_eid}
    zone.add_category(category)
  end
end

def categorize_groups
  cs=CSV.open('spec/fixtures/group_categories.csv')
  cs_keys = cs.readline.map {|e| e.split(':')}
  cs.each do |res_eid,category_eid|
    res=archive.resources.find {|r| r.externalID == res_eid}
    category=resources[:category].find {|c| c.externalID == category_eid}
    res.add_category(category)
  end
end


def read_things
  populate_resources
end

def group_things
  group_networks
  group_customers
  group_locations
  group_assets
  group_categories
end

def relate_things
  network_zones
  locate_zones
  network_customers
  zone_assets
end

def categorize_things
  categorize_assets
  categorize_zones
  categorize_groups
end


def write_archive
  File.open('tmp/fixture.xml','w') {|f| f.puts archive.xml.to_s}
end

def do_it
  read_things
  archive.add(*resources.values.flatten)
  group_zones
  relate_things
  group_things
  categorize_things
  write_archive
end

