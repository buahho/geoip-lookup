module get_domains
  module domains_module
    def get_domains_geo(domain)
      geoipcountry = `geoiplookup #{server} | grep Country | awk -F ': ' '{print $2}'`.strip()
      geoipcity = `geoiplookup -f /usr/share/GeoIP/GeoLiteCity.dat -l #{server} | awk -F ': ' '{print $2}'`.strip()
      geoipdata = {"GeoIP Country Edition" => geoipcountry, "GeoIP City Edition, Rev 1" => geoipcity} unless geoipcountry.include? "can't resolve hostname"
      return geoipdata
    end
  end
end
