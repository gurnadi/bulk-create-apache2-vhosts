#!/bin/bash

vhost_location='/etc/apache2/sites-available/'
#vhost_location='/tmp/tmp/'

vhost_docroot='/var/www/mycompany/dep/SUBDOM/controller'

vhost_template="<VirtualHost *:80>\n
        ServerAdmin     engineers@mycompany.com\n
        ServerName      VHOST\n
\n
        DocumentRoot $vhost_docroot/\n
\n
        <Directory $vhost_docroot>\n
                Options Indexes FollowSymLinks MultiViews\n
                AllowOverride All\n
                Order allow,deny\n
                allow from all\n
        </Directory>\n
\n
        ErrorLog \${APACHE_LOG_DIR}/error-VHOST.log\n
        LogLevel error\n
\n
        CustomLog \${APACHE_LOG_DIR}/access-VHOST.log combined\n
</VirtualHost>"

########### START ################################
vhost=( `cat "vhosts-list.txt" `)

for t in "${vhost[@]}"
do
	echo $t

	# write VHOST.conf
	echo -e $vhost_template > $vhost_location/$t.conf

	# get the SUBDOM
	subdom=`echo $t | /usr/bin/cut -d'.' -f 1`

	# find & replace all VHOST
	/bin/sed -i -e "s/VHOST/$t/g" $vhost_location/$t.conf

	# find & replace all SUBDOM
	/bin/sed -i -e "s/SUBDOM/$subdom/g" $vhost_location/$t.conf

	# enable this vhost
	/usr/sbin/a2ensite $t

	# if you need SSL certificate for this vhost, 
	# you can use Let's Encrypt
	# NOTE: this vhost's DNS must be already resolvable 
	#/usr/bin/certbot --apache -d $t

done

# restart apache to activate the new vhosts
/etc/init.d/apache2 restart

# done !
