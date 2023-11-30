FROM ubuntu:latest

# Update the package list and install curl and kubectl
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get install -y apt-transport-https && \
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

# Clean up the package cache to reduce image size
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY restart.sh .

RUN chmod +x restart.sh
CMD ["/bin/bash","./restart.sh"]

