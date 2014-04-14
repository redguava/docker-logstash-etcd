FROM redguava/centos
RUN yum install -y java-1.7.0-openjdk.x86_64
RUN curl -O https://download.elasticsearch.org/logstash/logstash/logstash-1.4.0.tar.gz && tar xzf logstash-1.4.0.tar.gz
RUN curl -O https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.1.0.tar.gz && tar xzf elasticsearch-1.1.0.tar.gz

ADD logstash.conf /logstash.conf

ADD supervisor-logstash.conf /etc/supervisord.d/logstash.conf
ADD supervisor-elasticsearch.conf /etc/supervisord.d/elasticsearch.conf
CMD /run.sh
