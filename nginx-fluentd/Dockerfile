# Base Image
FROM debian:stretch

# Maintainer
MAINTAINER Kouta Okamoto <okakou0512@gmail.com>

# Set Non interactive install
ENV DEBIAN_FRONTEND=noninteractive

# Install Nginx
RUN apt-get update
RUN apt-get install -y nginx

# Install Fluentd
RUN apt-get install -y sudo procps gnupg curl make gcc g++ libc-dev ruby-dev
RUN curl -O https://packages.treasuredata.com/GPG-KEY-td-agent
RUN apt-key add GPG-KEY-td-agent
RUN curl -L https://toolbelt.treasuredata.com/sh/install-debian-stretch-td-agent2.sh | sh
RUN td-agent-gem install fluent-plugin-elasticsearch
RUN echo " \n\
# input from nginx access_log \n\
<source> \n\
  @type tail \n\
  path /var/log/nginx/access.log \n\
  format nginx \n\
  tag nginx.access \n\
  pos_file /var/log/nginx/access.log.pos \n\
</source> \n\
 \n\
# output to elasticsearch \n\
<match nginx.access> \n\
  @type elasticsearch \n\
 \n\
  logstash_format true \n\
  logstash_prefix nginx \n\
 \n\
  host luffy.home \n\
  port 9200 \n\
 \n\
  type_name accesslog \n\
</match> \n\
" >> /etc/td-agent/td-agent.conf
RUN sed -i "s/TD_AGENT_USER=td-agent/TD_AGENT_USER=root/" /etc/init.d/td-agent

# Access Port
EXPOSE 8080

# Install run script
ADD run.sh /run.sh

# Set run command
CMD [ "/run.sh" ]
