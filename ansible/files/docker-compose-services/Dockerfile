FROM ubuntu:20.10

WORKDIR /app

EXPOSE 80 443

VOLUME /data/datainsider /var/log/datainsider ${PWD}


RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y python3 python3-pip vim curl \
  && curl -L "https://github.com/docker/compose/releases/download/v2.8.0/docker-compose-$(uname -s| tr '[:upper:]' '[:lower:]')-$(uname -m)" -o /usr/local/bin/docker-compose \
  && chmod +x /usr/local/bin/docker-compose \
  && mkdir -p /etc/apt/keyrings \
  && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg \
  && echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null \
  && apt-get update \
  && apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

COPY . /app

RUN /usr/local/bin/docker-compose up


RUN yum update -y \
  && yum install -y yum-utils python3 python3-pip vim curl \
  && yum-config-manager \
  --add-repo \
  https://download.docker.com/linux/centos/docker-ce.repo \
  && yum install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin \
  && curl -L "https://github.com/docker/compose/releases/download/v2.8.0/docker-compose-$(uname -s| tr '[:upper:]' '[:lower:]')-$(uname -m)" -o /usr/local/bin/docker-compose \
  && chmod +x /usr/local/bin/docker-compose
