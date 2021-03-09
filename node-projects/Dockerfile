FROM codercom/enterprise-node:ubuntu

USER root

# install apt packages
RUN apt-get update && apt-get install -y nano

# install npm global dependencies
# see https://medium.com/@aguidrevitch/when-installation-of-global-package-using-npm-inside-docker-fails-b551b5dda389
RUN npm -g config set user root
RUN npm install -g \
    eslint@7.10.0 \
    forever@3.0.2 \
    gatsby-cli@2.12.100 \
    generator-code@1.3.2 \
    json-server@0.16.2 \
    netlify-cli@3.8.5 \
    synk \
    vsce@1.83.0 \
    @vue/cli \
    wallpaper-everyday@3.0.0 \
    yo@3.1.1

USER coder
