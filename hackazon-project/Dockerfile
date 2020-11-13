FROM pierrickv/hackazon:latest

# Install developer tools
RUN apt-get update && apt-get install -y git openssh-client nano build-essential python2.7

# Install Phpstorm.
RUN mkdir -p /opt/phpstorm
RUN curl -L "https://download.jetbrains.com/product?code=PS&latest&distribution=linux" | tar -C /opt/phpstorm --strip-components 1 -xzvf -

# Add a binary to the PATH that points to the phpstorm startup script.
RUN ln -s /opt/phpstorm/bin/phpstorm.sh /usr/bin/phpstorm

# Copy the config (assume the MySQL service has been attached)
COPY config/db.php /var/www/html/assets/config/db.php

# Fixes PHP timezone crash issue
COPY web/index.php /var/www/html/web/index.php

# Fix permissions
RUN chown -R www-data:www-data /var/www/html/