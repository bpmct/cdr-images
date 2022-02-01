FROM ubuntu:20.04

USER root

# Install dependencies
RUN apt-get update && \
DEBIAN_FRONTEND="noninteractive" apt-get install --yes \
bash \
sudo \
git \
ssh \
locales \
wget \
r-base \
gdebi-core

# Install RStudio
RUN wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.4.1717-amd64.deb && \
gdebi --non-interactive rstudio-server-1.4.1717-amd64.deb

# Create coder user
RUN useradd coder \
--create-home \
--shell=/bin/bash \
--uid=1000 \
--user-group && \
echo "coder ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers.d/nopasswd

# Ensure rstudio files can be written to by the coder user.
RUN chown -R coder:coder /var/lib/rstudio-server
RUN echo "server-pid-file=/tmp/rstudio-server.pid" >> /etc/rstudio/rserver.conf
RUN echo "server-data-dir=/tmp/rstudio" >> /etc/rstudio/rserver.conf
RUN echo "www-frame-origin=same" >> /etc/rstudio/rserver.conf

# Remove the following line if you do not run Coder on https
RUN echo "server-add-header=X-Forwarded-Proto: https" >> /etc/rstudio/rserver.conf

# Assign password "rstudio" to coder user.
RUN echo 'coder:rstudio' | chpasswd

# Assign locale
RUN locale-gen en_US.UTF-8

# Run as coder user
USER coder

# Add RStudio to path
ENV PATH /usr/lib/rstudio-server/bin:${PATH}
