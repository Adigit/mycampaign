>/var/www/EmailService/log/klout.log
>/var/www/EmailService/log/update_geo.log
>/var/www/EmailService/log/free.log
>/var/www/usersdelight/log/development.log
Date=`date "+%m%d%y%n"`
cp /var/www/usersdelight/log/production.log /var/www/usersdelight/log/production.log."$Date"
gzip -f /var/www/usersdelight/log/production.log."$Date"
>/var/www/usersdelight/log/production.log
>/var/log/apache2/access.log
>/var/log/apache2/error.log
>/var/log/apache2/rewrite.log
>/var/log/syslog
>/var/log/nginx/access.log
>/var/log/nginx/error.log
>/var/log/haproxy
>/var/log/stunnel4/stunnel.log
>/var/log/messages
rm -f /var/log/apache2/*.gz
rm -f /var/log/*.gz
rm -f /var/log/stunnel4/stunnel.log.*
>/var/log/syslog
>/var/log/mail.log
>/var/log/mail.info

