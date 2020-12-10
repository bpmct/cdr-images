# Coder's base image from https://github.com/cdr/enterprise-images
FROM codercom/enterprise-base:ubuntu

# Run everything as root
USER root

# Install Node 12
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y nodejs

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN DEBIAN_FRONTEND="noninteractive" apt-get update && apt-get install -y yarn

# Install CodeTour extension on code-server
RUN /tmp/coder/code-server/code-server --install-extension vsls-contrib.codetour

# Set back to coder user
USER coder