#!/usr/bin/ruby
#######################################################################
## Copyright (c) 2016 Diego Martinez Lomas
##
## This scritps gets geoip data from input domains and puts the results 
## in a YAML file stored in the home directory of the user that runs it.
##
## Tested on ubuntu 14.04
#######################################################################

require 'getopt/std'
require 'yaml'

def usage
  printf "Usage: rb_backup_node.rb [-h][SERVER1 SERVER2 ...]\n"
  printf "    -h                      -> print this help\n"
  exit 0
end

# Initial variables
  geoipdatabase = {}
  geoipcountry = {}
  geoipcity = {}
  opt  = Getopt::Std.getopts("h")

# Usage
  usage() if opt['h'] or ARGV==""

# Begin
if `locate geoiplookup` != "" and File.exists?("/usr/share/GeoIP/GeoLiteCity.dat")
  geoipdatabase = YAML.load_file(ENV['HOME']+"/geoip-database.yml") if File.exist?(ENV['HOME']+"/geoip-database.yml")
  ARGV.each { |server|
    geoipcountry = `geoiplookup #{server} | grep Country | awk -F ': ' '{print $2}'`.strip()
    geoipcity = `geoiplookup -f /usr/share/GeoIP/GeoLiteCity.dat -l #{server} | awk -F ': ' '{print $2}'`.strip()
    if geoipcountry.include? "can't resolve hostname"
      printf "#{geoipcountry}\n"
    else
      if geoipdatabase[server] == nil
        geoipdatabase[server] = {"GeoIP Country Edition" => geoipcountry, "GeoIP City Edition, Rev 1" => geoipcity}
      else
        geoipdatabase[server]["GeoIP Country Edition"] = geoipcountry
        geoipdatabase[server]["GeoIP City Edition, Rev 1"] = geoipcity
      end
    end
  }
  output = YAML.dump geoipdatabase
  File.write(ENV['HOME']+"/geoip-database.yml", output) 
else
  printf "Please, verify geoiplookup and GeoLiteCity packages are installed.\n"
end
