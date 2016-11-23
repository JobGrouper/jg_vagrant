#!/bin/sh

#Definitions
WEBROOT="/home/jobgrou2/public_html/"
VHOSTDIR="/etc/httpd/conf.d/"
SKELETON_FILE="/vagrant/manifests/vhost-skeleton"
TITLE="jobgrouper"

# Tell Apache where to look for conf files
sudo sed -i -e "$ G" /etc/httpd/conf/httpd.conf
sudo sed -i -e "$ a NameVirtualHost *:80" /etc/httpd/conf/httpd.conf
sudo sed -i -e "$ a EnableSendfile off" /etc/httpd/conf/httpd.conf

# Copy skeleton file into config directory
#
if [ ! -f "$VHOSTDIR$TITLE.conf" ]; then
  sudo cp "$SKELETON_FILE" "$VHOSTDIR$TITLE.conf"
  echo "Created $VHOSTDIR$TITLE.conf"
else
  sudo mv "$VHOSTDIR$TITLE.conf" "$VHOSTDIR$TITLE.bak"
  sudo cp "$SKELETON_FILE" "$VHOSTDIR$TITLE.conf"
  echo "Created $VHOSTDIR$TITLE.conf and made a backup of the existing conf"
fi

# Replace SKELETON with specific values
sudo find "$VHOSTDIR$TITLE.conf" -type f -exec sed -i "s/SKELETON/jobgrouper/" {} \;
sudo find "$VHOSTDIR$TITLE.conf" -type f -exec sed -i "s/SKEL\_ROOT/application\/public/" {} \;
sudo find "$VHOSTDIR$TITLE.conf" -type f -exec sed -i "s/SKEL\_DOMAIN/jobgrouper.build/" {} \;
sudo find "$VHOSTDIR$TITLE.conf" -type f -exec sed -i "s/SKEL\_ALIAS/local.jobgrouper.build/" {} \;

#$RESTARTCMD
echo "Restarting Apache"
sudo service httpd restart
