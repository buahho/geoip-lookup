
#
# Cookbook Name:: geoip-lookup
# Recipe:: default
#
# Installs script that perform a geo localization of a DNS list.
# Also install or upgrade all dependencies
#

require 'yaml'

package "Install geoip-lookup" do
  case node[:platform]
    when 'redhat','centos'
      package_name ['GeoIP','GeoIP-data','ruby']
    when 'ubuntu', 'debian'
      package_name ['geoip-database','geoip-bin','libgeoip-dev','ruby']
  end
  action :nothing
end.run_action(:upgrade)

cookbook_file "/usr/bin/geoipresolv.rb" do
  source "geoipresolv.rb"
  mode '0644'
  action :create
end

execute 'Download GeoLiteCity.dat.gz' do
  command 'wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz'
  cwd '/usr/share/GeoIP'
  not_if { File.exists?("/usr/share/GeoIP/GeoLiteCity.dat") }
end

execute 'Extract GeoLiteCity.dat.gz' do
  command 'gunzip GeoLiteCity.dat.gz'
  cwd '/usr/share/GeoIP'
  not_if { File.exists?("/usr/share/GeoIP/GeoLiteCity.dat") }
end

execute "Execute script geoipreolv.rb to find geolocalization of domains stored on the current node" do
  command "ruby /usr/bin/geoipresolv.rb #{node["geoip_data"]["domains"].join(' ')}"
end
