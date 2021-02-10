# This image is configured to run https://github.com/tilt-dev/tilt-example-java/ in Coder

# bencdr/k8s-tilt contains a kind cluster + Tilt installed 
FROM bencdr/k8s-tilt:latest

USER root

# Install project dependencies (OpenJDK 8, unzip, rsync, python)
RUN DEBIAN_FRONTEND="noninteractive" apt-get update && apt-get install -y openjdk-8-jdk unzip rsync python
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $PATH:$JAVA_HOME/bin

# Install IntelliJ IDE (extra, but good for Java development)
RUN mkdir -p /opt/idea
RUN curl -L "https://download.jetbrains.com/product?code=IIC&latest&distribution=linux" | tar -C /opt/idea --strip-components 1 -xzvf -
RUN ln -s /opt/idea/bin/idea.sh /usr/bin/intellij-idea-community

# Copy and run this additional configure script after the first one
COPY configure /coder/configure-java-example
RUN echo '# [Imported from k8s-tilt-example-java]' >> "/home/coder/configure"
RUN echo 'sh /coder/configure-java-example' >> "/home/coder/configure"

# Set back to coder user
USER coder