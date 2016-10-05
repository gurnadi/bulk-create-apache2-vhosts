# bulk-create-apache2-vhosts
Create bulk virtual host apache web server based on bash script.

Just follow these simple steps : 

(1) Put the vhost names in a file called vhosts-list.txt, one vhost / domain at each line
(2) Make sure the content of vhost_docroot variable is correct.
(3) Make sure the content of vhost_template variable is correct.

And that's it :) it can even setup the SSL certificates for them :) just make sure the "certbot" line is unremarked. 

This original script made by Harry Sufehmi @sufehmi.
