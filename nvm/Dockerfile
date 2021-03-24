FROM codercom/enterprise-base:ubuntu

USER root

# Set NVM_DIR outside of the home directory so it doesn't persist across rebuilds
ENV NVM_DIR=/usr/bin/nvm

RUN mkdir -p $NVM_DIR
RUN chown coder:coder $NVM_DIR

# Set the default shell for this workspace
RUN chsh -s /bin/bash

# Install nvm as the "coder" user
USER coder
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    # Install any Node versions we need
    && nvm install 12.21.0 \
    && nvm install 15.12.0 \
    && nvm alias default 15.12.0 \
    && nvm use default \
    # Install global packages on the default version of node
    && npm install -g yarn@v1.22.5

# Copy configure script (we need this to add nvm to our path)
COPY configure /coder/configure