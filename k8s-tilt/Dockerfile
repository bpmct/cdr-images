FROM codercom/enterprise-base:lsblk -f.

# Run everything as root
USER root

# Install go1.15
RUN curl -L "https://dl.google.com/go/go1.15.3.linux-amd64.tar.gz" | tar -C /usr/local -xzvf -

# Setup go env vars
ENV GOROOT /usr/local/go
ENV PATH $PATH:$GOROOT/bin

ENV GOPATH /home/coder/go
ENV GOBIN $GOPATH/bin
ENV PATH $PATH:$GOBIN

# kubectl (with bash completion)
ARG k8s_version=v1.18.2
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -  \
    && echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
    && apt-get update \
    && apt-get install kubectl="${k8s_version#v}"-00 \
    && apt-get install bash-completion \
    && kubectl completion bash >/etc/bash_completion.d/kubectl \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Set back to coder user
USER coder

# K8s.io KinD
RUN git clone https://github.com/kubernetes-sigs/kind.git /home/coder/kind

USER root

# Install Sysbox

# Build the KinD tool
COPY build-kind.sh /usr/bin
RUN chmod +x /usr/bin/build-kind.sh && build-kind.sh && rm /usr/bin/build-kind.sh