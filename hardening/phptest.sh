if [ -z "${PHPVersion}" ]; then
      echo "Running PHPv7..."
      apt-get update && apt-get install -y --no-install-recommends git=* && rm -rf /var/lib/apt/lists/* && cd / && \
    git clone https://github.com/jvoisin/snuffleupagus && cd snuffleupagus/src && phpize && ./configure --enable-snuffleupagus && make && make install && docker-php-ext-enable snuffleupagus
    echo "sp.configuration_file=/usr/local/etc/php/conf.d/snuffleupagus.rules" >> /usr/local/etc/php/conf.d/docker-php-ext-snuffleupagus.ini
    wget "https://raw.githubusercontent.com/Elrondo46/apache-php/master/hardening/hard_php7.rules"
    mv hard_php7.rules /etc/php/conf.d/snuffleupagus.rules


   else

      echo "Running PHPv8..."
      apt-get update && apt-get install -y --no-install-recommends git=* && rm -rf /var/lib/apt/lists/* && cd / && \
    git clone https://github.com/jvoisin/snuffleupagus && cd snuffleupagus/src && phpize && ./configure --enable-snuffleupagus && make && make install && docker-php-ext-enable snuffleupagus
    echo "sp.configuration_file=/usr/local/etc/php/conf.d/snuffleupagus.rules" >> /usr/local/etc/php/conf.d/docker-php-ext-snuffleupagus.ini
      echo "sp.configuration_file=/etc/php/conf.d/snuffleupagus.rules" >> /usr/local/etc/php/conf.d/docker-php-ext-snuffleupagus.ini"
      wget "https://raw.githubusercontent.com/Elrondo46/apache-php/master/hardening/hard_php8.rules"
      mv hard_php7.rules /etc/php/conf.d/snuffleupagus.rules
    fi
