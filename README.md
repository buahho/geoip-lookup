DESCRIPTION
====

Installs a script and dependencies that gets geoip location of domains given as input and writes the output to a YAML file stored in /etc/domains_geo.yml.

Also install a cookbook that creates and attribute default["geoip_data"]["domains"] where some domains are stored.

This cookbook runs some operations that gets domains stored on default["geoip_data"]["domains"] and gets its geolocalization
and store them in default["geoip_data"]["domains_geo"] and also perform a backup in the file /etc/domains_geo.yml

REQUIREMENTS
====

Tested on Ubuntu 12.04.

USAGE
====

geoip_resolv.rb DOMAIN1 DOMAIN2 DOMAIN3 ...

LICENSE AND AUTHOR
====

Author:: Diego Martinez Lomas (<buahho@gmail.com>)
Copyright:: 2016, Diego Martinez Lomas
