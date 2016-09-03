#
# Cookbook Name:: geoip-lookup
# Recipe:: default
#
# Installs script that perform a geo localization of DNS list.
# Also install or upgrade all dependencies
#
extend get_domains::domains_module
require 'yaml'

package "Install geoip-lookup" do
  case node[:platform]
    when 'redhat','centos'
      package_name ['GeoIP','GeoIP-data']
    when 'ubuntu', 'debian'
      package_name ['geoip-database','geoip-bin','libgeoip-dev']
  end
  action :nothing
end.run_action(:upgrade)

node["geoip_data"]["domains"].each do |domain|
  output = get_domains_geo(domain)
  node.default["geoip_data"]["domains_geo"][domain] = output
end

cookbook_file '/usr/bin/geoip_resolv.rb' do
  source 'geoip_resolv.rb'
  owner 'root'
  group 'root'
  mode '0755'
  action :create_if_missing
end

template "/etc/domains_geo.yml" do
  mode '0644'
  variables :content => YAML::dump(YAML::dump(node["geoip_data"]["domains_geo"].to_hash).gsub('!map:Mash',''))
  source "domains_geo.yml.erb"
end
