#!/bin/bash

CMSVALUE=$CMS
FILETEST=index.php

case $CMSVALUE in

wordpress)
  if [ -f /var/www/html/"$FILETEST" ]; then
    echo "Wordpress or another CMS already installed, Install nothing"
  else
    wget "https://wordpress.org/latest.zip"
    unzip '*.zip' -d /var/www/html
    mv wordpress/* .
    mv wordpress/.* .
    rm -r wordpress
    rm latest.zip
    sed -i "2 i if ($_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https') $_SERVER['HTTPS']='on';" wp-settings.php
    chown -R 33:33 /var/www/html
  fi
    ;;

drupal)
  if [ -f /var/www/html/"$FILETEST" ]; then
    echo "Drupal or another CMS already installed, Install nothing"
  else
    wget "https://www.drupal.org/download-latest/zip"
    unzip zip -d /var/www/html
    mv drupal-* drupal
    mv drupal/* .
    mv drupal/.* .
    rm -r drupal
    rm zip
    chown -R 33:33 /var/www/html
  fi
;;

*)
  echo "No CMS Detected, continue without CMS but you can define this variable later"
esac

set -e

echo "account default" > /etc/msmtprc
echo "host $SMTP_HOST" >> /etc/msmtprc
echo "port $SMTP_PORT" >> /etc/msmtprc
echo "tls $SMTP_TLS" >> /etc/msmtprc
echo "tls_starttls $SMTP_STARTTLS" >> /etc/msmtprc
echo "from $SMTP_FROM"  >> /etc/msmtprc
echo "auth $SMTP_AUTH" >> /etc/msmtprc
echo "user $SMTP_USERNAME" >> /etc/msmtprc
echo "password $SMTP_USERNAME" >> /etc/msmtprc

exec apache2-foreground
