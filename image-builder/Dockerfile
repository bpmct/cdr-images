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
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    nano \
    unzip

# Install Docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
    && add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable" \
    && apt-get update \
    && apt-get install -y docker-ce docker-ce-cli containerd.io

# Install AWS Cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

# Add a user `coder` so that you're not developing as the `root` user
RUN adduser --gecos '' --disabled-password coder && \
  echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd
USER coder
