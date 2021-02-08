FROM codercom/enterprise-base:ubuntu

# Install docker compose
RUN sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN sudo chmod +x /usr/local/bin/docker-compose

# Set sysbox as the default runtime
COPY docker-daemon.json /etc/docker/daemon.json
# Restart docker daemon
RUN sudo systemctl restart docker
# Install sysbox
RUN wget https://github.com/nestybox/sysbox/releases/download/v0.2.1/sysbox_0.2.1-0.ubuntu-focal_amd64.deb
RUN sudo apt-get install ./sysbox_0.2.1-0.ubuntu-focal_amd64.deb -y
