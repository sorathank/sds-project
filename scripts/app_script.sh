#!/bin/bash
apt update -y
apt upgrade -y

apt install -y mariadb-client-core-10.3 apache2 libapache2-mod-php7.4 php7.4-gd php7.4-mysql php7.4-curl php7.4-mbstring php7.4-intl php7.4-gmp php7.4-bcmath php-imagick php7.4-xml php7.4-zip unzip
wget https://download.nextcloud.com/server/releases/nextcloud-22.2.0.zip
unzip nextcloud-22.2.0.zip
mv nextcloud/* /var/www/html

a2enmod rewrite
a2enmod ssl
a2ensite default-ssl

service apache2 restart

cd /var/www/html

echo "<?php
\$CONFIG = array (
  'objectstore' => array(
        'class' => '\\OC\\Files\\ObjectStore\\S3',
        'arguments' => array(
                'bucket' => '${BUCKET_NAME}',
                'key'    => '${ACCESS_ID}',
                'secret' => '${ACCESS_SECRET}',
                'port' => 443,
                'use_ssl' => true,
                'region' => '${REGION}',
                'use_path_style'=>true,
        ),
  ),
);" > /var/www/html/config/config.php

php occ maintenance:install --database "mysql" --database-name "${database_name}"  --database-user "${database_user}" --database-pass "${database_pass}" --admin-user "${admin_user}" --admin-pass "${admin_pass}" --database-host "10.0.2.101"

php occ config:system:set trusted_domains 1 --value=${PUBLIC_IP}

chown -R www-data:www-data /var/www/html

