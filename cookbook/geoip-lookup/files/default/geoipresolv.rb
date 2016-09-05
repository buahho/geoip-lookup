#!/usr/bin/ruby
#######################################################################
## Copyright (c) 2016 Diego Martinez Lomas
##
## This scritps gets geoip data from input domains and puts the results
## in a file stored in the home directory of the user that runs it.
##
## Tested on ubuntu 12
#######################################################################

def usage
  printf "Usage: geoipresolv.rb SERVER1, SERVER2, ...\n"
  exit 0
end

# Usage
  usage() if ARGV==""

# Class to execute threads of geolocalization domains
class Gelocalization
  def initialize(domains = [], filename = nil)
    @domains = domains
    unless filename.nil?
      @filename = filename
      @running = true
    end
    start()
  end

  def start()
    threads = []
    @domains.each do |domain|
      threads << Thread.new do
        geoipresolv(domain,@filename)
      end
    end
    threads.each { |t| t.join }
  end

  def geoipresolv(domain,filename)
    geoipcountry = `geoiplookup #{domain} | grep Country | awk -F ': ' '{print $2}'`.strip()
    geoipcity = `geoiplookup -f /usr/share/GeoIP/GeoLiteCity.dat -l #{domain} | awk -F ': ' '{print $2}'`.strip()
    if geoipcountry.include? "can't resolve hostname"
      geoipcountry = "can't resolve hostname"
      geoipcity = "can't resolve hostname"
    end
    if @running
        geoipdata = "#{domain}:\n  GeoIP Country Edition: #{geoipcountry}\n  GeoIP City Edition, Rev 1: #{geoipcity}\n"
        file_output = open(filename,'a')
        file_output.write(geoipdata)
        file_output.close
    end
  end
end

# Begin
filename = ENV['HOME']+"/geoip-database.dat"
domains = ARGV
Gelocalization.new(domains, filename)
