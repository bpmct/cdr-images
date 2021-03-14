FROM bencdr/docker-sandbox:latest

USER root

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

# Copy configure script
COPY configure /coder/configure

USER coder
