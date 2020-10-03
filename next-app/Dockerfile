FROM ubuntu:20.04

# Update the OS packages and install any developer friendly utilities
# needed in your development environment
RUN apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
    # Development utilities
    git \
    bash \
    curl \
    htop \
    man \
    vim \
    ssh \
    sudo \
    lsb-release \
    ca-certificates \
    locales \
    gnupg \
    # Packages required for multi-editor support
    libxtst6 \
    libxrender1 \
    libfontconfig1 \
    libxi6 \
    libgtk-3-0

# Install the yarn package manager
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

# Install WebStorm
RUN mkdir -p /opt/webstorm
ENV WEBSTORM_VERSION=2020.1.1
RUN curl -L https://download.jetbrains.com/webstorm/WebStorm-${WEBSTORM_VERSION}.tar.gz | tar -C /opt/webstorm --strip-components 1 -xzvf -

# Add a binary to the PATH that points to the webstorm startup script
RUN ln -s /opt/webstorm/bin/webstorm.sh /usr/bin/webstorm

# Add a user `coder` so that you're not developing as the `root` user
RUN adduser --gecos '' --disabled-password coder && \
  echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd
USER coder

COPY [ "configure", "/coder/configure" ]