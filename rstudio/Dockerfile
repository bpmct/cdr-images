FROM ubuntu:20.04

USER root

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

# install RStudio
RUN wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.4.1717-amd64.deb && \
    gdebi --non-interactive rstudio-server-1.4.1717-amd64.deb

# create Coder user
RUN useradd coder \
    --create-home \
    --shell=/bin/bash \
    --uid=1000 \
    --user-group && \
    echo "coder ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers.d/nopasswd

# give Coder user a passsword for RStudio
RUN chown -R coder:coder /var/lib/rstudio-server
RUN echo "server-pid-file=/tmp/rstudio-server.pid" >> /etc/rstudio/rserver.conf
RUN echo "server-data-dir=/tmp/rstudio" >> /etc/rstudio/rserver.conf
RUN echo 'coder:rstudio' | chpasswd

# fix locale stuff
RUN locale-gen en_US.UTF-8

USER coder

ENV PATH /usr/lib/rstudio-server/bin:${PATH}