# apache-php

Docker Image of Apache with: 

-   Ready to connect with Redis
-   Ready to connect to SMTP
-   Selectable CMS with Wordpress, Drupal, SPIP and DotClear (Staging but usable) 
-   Ready to use apache custom site with PHP

## Example of Docker Composer file in Generic Use (tag latest or staging)
```yaml
version: "3"

services:

  db:
    image: mariadb:latest
    restart: always
    volumes:
      - "db_data:/var/lib/mysql"
    environment:
      - MYSQL_DATABASE=test
      - MYSQL_USER=test
      - MYSQL_PASSWORD=test
      - MYSQL_ROOT_PASSWORD=test
  
  www:
    image: tuxnvape/apache-php-redis:stable
    restart: always
    volumes:
      - "www_data:/var/www/html"
    ports:
      - 80:80
    environment:
      - SMTP_FROM=toto@test.fr
      - SMTP_HOST=container_mail
      - SMTP_PORT=587
  
  redis:
    image: redis:latest
    restart: always
  
  mail:
    image: boky/postfix
    restart: always
    environment:
      RELAYHOST: smtp.realserver.fr
      RELAYHOST_USERNAME: "test"
      RELAYHOST_PASSWORD: "test"
      MYNETWORKS: "172.1.0.0/16"
      
volumes:
  www_data:
  db_data:
```

## Example of Docker Composer file with CMS select (Staging ONLY)
```yaml
version: "3"

services:

  db:
    image: mariadb:latest
    restart: always
    volumes:
      - "db_data:/var/lib/mysql"
    environment:
      - MYSQL_DATABASE=test
      - MYSQL_USER=test
      - MYSQL_PASSWORD=test
      - MYSQL_ROOT_PASSWORD=test
  
  www:
    image: tuxnvape/apache-php-redis:staging
    restart: always
    volumes:
      - "www_data:/var/www/html"
    restart: always
    ports:
      - 80:80
    environment:
      - SMTP_FROM=toto@test.fr
      - SMTP_HOST=container_mail
      - SMTP_PORT=587
      - CMS=wordpress #you can choose between three CMS (wordpress, drupal, SPIP or DotClear)
  
  redis:
    image: redis:latest
    restart: always
  
  mail:
    image: boky/postfix
    restart: always
    environment:
      RELAYHOST: smtp.realserver.fr
      RELAYHOST_USERNAME: "test"
      RELAYHOST_PASSWORD: "test"
      MYNETWORKS: "172.1.0.0/16"
      
volumes:
  www_data:
  db_data:
```

## Why you choose http port and not https
Better using nginx-proxy or other proxy and link it directly to the www container.

## Can I select different PHP versions
Yes, watch the tags in Docker Hub page

## Multi-Arch support
Yes, amd64, armv7 and arm64 but only for stable. Stable CMS selector version soon in all supported archs.

## About Wordpress
Wordpress is fully pre-patched for HTTPS

## About DotClear
Fully functionnal in vanilla version, last version installed

## About Drupal
Tested install full sucessfull with latest version, all install mode are supported.

## About SPIP
SPIP is fully patched to use InnoDB and not the official legacy engine. It's 100% fully functionnal.
You need to add SPIP_VERSION variable
```yaml
SPIP_VERSION="4.0.0" #Current version
```
## WARNING
Be carefull if you choose Drupal, change for another CMS or no CMS can danage the original container datas in case of misconfiguration.
