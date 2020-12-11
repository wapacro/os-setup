#!/bin/bash

# Basics
apt update
apt upgrade --yes
apt install git curl tar net-tools traceroute nano ca-certificates apt-transport-https gnupg-agent software-properties-common --yes

# PHP & Extensions
packages="php$PHPVERSION php$PHPVERSION-bcmath php$PHPVERSION-redis php$PHPVERSION-curl php$PHPVERSION-gd php$PHPVERSION-gmp php$PHPVERSION-igbinary php$PHPVERSION-imagick php$PHPVERSION-mbstring php$PHPVERSION-xdebug"
add-apt-repository ppa:ondrej/php --yes
apt autoremove $packages --purge --yes
apt install $packages --yes

# Composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php --filename=composer
mv composer /usr/local/bin/composer
rm composer-setup.php

# Node.js & NPM
packages="nodejs npm build-essential"
curl -sL "https://deb.nodesource.com/setup_$NODEJSVERSION.x" | -E bash -
apt autoremove $packages --purge --yes
apt install $packages --yes

# Docker
packages="docker-ce docker-ce-cli containerd.io"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" --yes
apt autoremove $packages --purge --yes
apt install $packages --yes
usermod -aG docker $USER
systemctl enable docker

# CF CLI & Pack
packages="cf7-cli"
curl -fsSL https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | apt-key add -
add-apt-repository "deb https://packages.cloudfoundry.org/debian stable main" --yes
apt autoremove $packages --purge --yes
apt install $packages --yes
(curl -sSL "https://github.com/buildpacks/pack/releases/download/v$PACKVERSION/pack-v$PACKVERSION-linux.tgz" | tar -C /usr/local/bin/ --no-same-owner -xzv pack)

# Azure CLI
packages="azure-cli"
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" --yes
apt autoremove $packages --purge --yes
apt install $packages --yes