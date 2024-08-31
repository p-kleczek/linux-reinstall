#! /bin/bash

DOKUWIKI_ID=$1
LOCAL_DOKUWIKI_DIR=$2  # Should end with .../dokuwiki/
# e.g.: DOKUWIKI_ID=mszana_wiki ; LOCAL_DOKUWIKI_DIR="/home/pawel/Projects/MszanaDln/wiki/dokuwiki/"

WWW_DIR=/var/www/

echo "Creating a symbolic link in ${WWW_DIR}..."
# sudo mkdir /var/www/${DOKUWIKI_ID}
sudo rm ${WWW_DIR}${DOKUWIKI_ID}
sudo ln -s "${LOCAL_DOKUWIKI_DIR}" ${WWW_DIR}${DOKUWIKI_ID}

echo "Creating a .conf file..."
sudo tee /etc/apache2/sites-available/${DOKUWIKI_ID}.conf > /dev/null <<EOT
<VirtualHost 127.0.0.1>
    	ServerName	localhost
    	DocumentRoot  ${WWW_DIR}${DOKUWIKI_ID}/

    	ErrorLog   /var/log/apache2/${DOKUWIKI_ID}.log
    	CustomLog  /var/log/apache2/${DOKUWIKI_ID}.log combined

    	<Directory ${WWW_DIR}${DOKUWIKI_ID}/>
        	Options -Indexes +FollowSymLinks -MultiViews
        	AllowOverride All
        	Require all granted
    	</Directory>
</VirtualHost>
EOT

echo "Enabling the site..."
sudo a2ensite ${DOKUWIKI_ID}.conf

echo "Restarting Apache..."
sudo systemctl reload apache2

echo "Giving 'x' permissions for 'others' to all directories on the path to 'local' site's directory..."
LEVEL_UP=$LOCAL_DOKUWIKI_DIR
while [[ "$LEVEL_UP" != "/home" ]]; do
	chmod o+x $LEVEL_UP
	echo "Added o+x permission to: $LEVEL_UP"
	LEVEL_UP=$(dirname $LEVEL_UP)
	# if [[ "$LEVEL_UP" != "/home" ]]; then
	# 	break
	# fi
done

echo "Giving proper permissions for all site's files..."
sudo chmod -R 775 ${LOCAL_DOKUWIKI_DIR}
sudo chown -R pawel:www-data ${LOCAL_DOKUWIKI_DIR}

# Enable module rewrite.
sudo a2enmod rewrite

echo "Restarting Apache..."
sudo systemctl restart apache2

echo " > Done."
