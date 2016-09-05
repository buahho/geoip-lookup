DESCRIPTION
====

Installs a script and dependencies that gets geoip location of domains given as input and writes the output to a file stored in the home directory as geoip_database.dat

Also install a cookbook that creates and attribute default["geoip_data"]["domains"] where some domains are stored.

This cookbook runs some operations that gets domains stored on default["geoip_data"]["domains"] and gets its geolocalization
and store them in the file geoip_database.dat stored in the home directory

REQUIREMENTS
====

Tested on Ubuntu 12.04.

Before executing the cookbook be aware of run "apt-get update" to be able to download packages needed by this cookbook.

USAGE
====
For running the cookbook with chef-solo:

chef-solo -c solo.rb -j solo.json

The scripts could also be run as:

geoipresolv.rb DOMAIN1 DOMAIN2 DOMAIN3 ...

LICENSE AND AUTHOR
====

Author:: Diego Martinez Lomas (<buahho@gmail.com>)
Copyright:: 2016, Diego Martinez Lomas
