#
# Cookbook Name:: geoip-lookup
# Recipe:: default
#
# Installs script that perform a geo localization of DNS list. 
# Also install or upgrade all dependencies
#

package "geoip-database" do
  action :upgrade
end

package "geoip-bin" do
  action :upgrade
end

package "libgeoip-dev" do
  action :upgrade
end

cookbook_file '/usr/bin/geoip_resolv.rb' do
  source 'geoip_resolv.rb'
  owner 'root'
  group 'root'
  mode '0755'
  action :create_if_missing
end
