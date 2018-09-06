#!/bin/bash
#
# Starts a Docker instance of the Bro IDS and tunes some settings for high throughput

###############################
#Edit these varibles as needed#
###############################
#CONTAINERINT is the interface within the Container
CONTAINERINT="net0"

#Need to copy our temporary mount site to allow Bro package manager to run
cp -rpf /conf/site/* /usr/local/bro/share/bro/site/

sudo chgrp $USER $(bro-config --site_dir) $(bro-config --plugin_dir)
sudo chmod g+rwX $(bro-config --site_dir) $(bro-config --plugin_dir)

sed -i "/const fanout_id/c\ \tconst fanout_id = $RANDOM &redef;" /usr/local/bro/lib/bro/plugins/Bro_AF_Packet/scripts/init.bro

/usr/local/bro/bin/bro -i $CONTAINERINT -e 'redef LogAscii::use_json=T;'
