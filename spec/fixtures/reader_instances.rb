asset_reader = ArcWeld::Readers::Csv.new(
  file_path:    'spec/fixtures/assets.csv', 
  target_class: ArcWeld::Asset)

category_reader = ArcWeld::Readers::Csv.new(
  file_path:    'spec/fixtures/categories.csv', 
  target_class: ArcWeld::AssetCategory)

customer_reader = ArcWeld::Readers::Csv.new(
  file_path:    'spec/fixtures/customers.csv', 
  target_class: ArcWeld::Customer)

group_reader = ArcWeld::Readers::Csv.new(
  file_path:    'spec/fixtures/groups.csv', 
  target_class: ArcWeld::Group)

location_reader = ArcWeld::Readers::Csv.new(
  file_path:    'spec/fixtures/locations.csv', 
  target_class: ArcWeld::Location)

network_reader = ArcWeld::Readers::Csv.new(
  file_path:    'spec/fixtures/networks.csv', 
  target_class: ArcWeld::Network)

zone_reader = ArcWeld::Readers::Csv.new(
  file_path:    'spec/fixtures/zones_cidr.csv', 
  target_class: ArcWeld::Zone)