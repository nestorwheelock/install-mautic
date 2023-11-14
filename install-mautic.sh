#!/bin/sh

hostname=`hostname`
db='mautic'
dbhost='127.0.0.1'
dbuser='mautic'
dbpass="$(openssl rand -base64 12)"

echo "Database: ${db}" > /root/mauticnotes
echo "Database Server:  ${dbhost}">> /root/mauticnotes
echo "Database User:  ${dbuser}" >> /root/mauticnotes
echo "Database Password:  ${dbpass}" >> /root/mauticnotes

ip='192.168.1.34'
mauticserver="mautic.scity.co"


tee -a /etc/rc.conf <<EOF
hostname="'${hostname}'"
apache24_enable="YES"
mysql_enable="YES"
EOF

pkg install -y openssl
pkg install -y nano

pkg install -y mariadb1011-server

mysql -e "CREATE DATABASE ${db} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
mysql -e "CREATE USER ${db}@${dbhost} IDENTIFIED BY '${dbpass}';"
mysql -e "GRANT ALL PRIVILEGES ON ${db}.* TO '${dbuser}'@'${mauticserver}';"
mysql -e "FLUSH PRIVILEGES;"


pkg install -y php80 
pkg install -y mod_php80
pkg install -y php80-iconv
pkg install -y php80-composer
pkg install -y php80-zip
pkg install -y php-tokenizer
pkg install -y php80-cli
pkg install -y php80-xml
pkg install -y php80-pdo
pkg install -y php80-mcrypt
pkg install -y php80-imap
pkg install -y php80-posix
pkg install -y php80-intl
pkg install -y php80-mysqli
pkg install -y php80-pear
pkg install -y php80-imap
pkg install -y php80-sockets
pkg install -y php80-curl
pkg install -y php80-gd
pkg install -y software-properties-common
pkg install -y php80-pcov
pkg install -y php80-fileinfo
pkg install -y php80-dom
pkg install -y php80-dom
pkg install -y php80-simplexml
pkg install -y php80-xmlreader
pkg install -y php80-xmlwriter
pkg install -y php80-pear
pkg install -y php80-session
pkg install -y php80-pdo_mysql
pkg install -y php80-mod_rewrite
pkg install -y apache24
pkg install -y mod-php80

pkg install -y py37-gdbm     
pkg install -y py37-sqlite3   
pkg install -y py37-tkinter    
pkg install -y npm

pkg install -y git

cd /usr/local/src

#git init
#git clone https://github.com/mautic/mautic.git
#rsync -rav mautic/* /usr/local/www/mautic/

wget https://github.com/mautic/mautic/releases/download/4.4.10/4.4.10.zip --no-check-certificate
mkdir /usr/local/www/mautic
mv 4.4.10.zip /usr/local/www/mautic
cd /usr/local/www/mautic
unzip 4.4.10.zip

chown -R root:www  /usr/local/www/mautic
find . -type d -not -perm 755 -exec chmod 755 {} +
find . -type f -not -perm 644 -exec chmod 644 {} +
chmod -R g+w app/cache/ app/logs/ app/config/
chmod -R g+w media/files/ media/images/ translations/

cp -f  /usr/local/etc/php.ini-production /usr/local/etc/php.ini

tee -a /usr/local/etc/php.ini <<EOF
file_uploads = On
allow_url_fopen = On
short_open_tag = On
upload_max_filesize = 100M
max_execution_time = 360
echo "memory_limit = 1024M"
echo "date.timezone = America/Cancun"
echo "always_populate_raw_post_data = -1"
EOF


systemctl restart httpd
