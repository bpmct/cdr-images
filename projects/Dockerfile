FROM codercom/enterprise-node:ubuntu

USER root

# install apt packages
RUN apt-get update && apt-get install -y nano

# install npm global dependencies
# see https://medium.com/@aguidrevitch/when-installation-of-global-package-using-npm-inside-docker-fails-b551b5dda389
RUN npm -g config set user root
RUN npm install -g \
    yarn

# Copy configure script
COPY configure /coder/configure

# Install homebrew packages
RUN brew install jq

USER coder
