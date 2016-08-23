#
# Cookbook Name:: geoiplookup-test
# Recipe:: default
#
# Installs script that perform a geo localization of DNS list
#

cookbook_file '/usr/bin/geoip_resolv.rb' do
  source 'geoip_resolv.rb'
  owner 'root'
  group 'root'
  mode '0755'
  action :create_if_missing
end
