FROM valerianomanassero/java-centos:latest

RUN rpm --import http://packages.elastic.co/GPG-KEY-elasticsearch
ADD elasticsearch.repo /etc/yum.repos.d/elasticsearch.repo
RUN yum -y install elasticsearch-5.5.2-1 sudo unzip
RUN yum -y clean all
ADD elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
ADD log4j2.properties /etc/elasticsearch/log4j2.properties
ADD jvm.options /etc/elasticsearch/jvm.options
ADD sudoers /etc/sudoers
USER root
RUN chown elasticsearch:elasticsearch /etc/elasticsearch/elasticsearch.yml
RUN mkdir /var/data
RUN chown elasticsearch:elasticsearch /var/data
RUN chmod -R 0777 /var/log/elasticsearch
RUN chmod -R 0777 /var/data
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin  install -b https://distfiles.compuscene.net/elasticsearch/elasticsearch-prometheus-exporter-5.4.0.0.zip
COPY docker-entrypoint.sh /
RUN chmod 755 /docker-entrypoint.sh
USER elasticsearch
EXPOSE 9200
ENTRYPOINT ["/docker-entrypoint.sh"]
