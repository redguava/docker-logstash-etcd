#!/bin/bash
ETCD_PEER="172.17.42.1:4001"
LOGSTASH_CONFIG=/logstash.conf

SYSLOG_S3_BUCKET=$(etcdctl --peers ${ETCD_PEER} get /config/SYSLOG_S3_BUCKET | egrep -v "Error: 100: Key not found|Cannot sync with the cluster" || echo "syslog_to_s3")
SYSLOG_S3_REGION=$(etcdctl --peers ${ETCD_PEER} get /config/SYSLOG_S3_REGION | egrep -v "Error: 100: Key not found|Cannot sync with the cluster" || echo "us-east-1")
SYSLOG_S3_ACCESS_KEY=$(etcdctl --peers ${ETCD_PEER} get /config/SYSLOG_S3_ACCESS_KEY | egrep -v "Error: 100: Key not found|Cannot sync with the cluster")
SYSLOG_S3_SECRET_KEY=$(etcdctl --peers ${ETCD_PEER} get /config/SYSLOG_S3_SECRET_KEY | egrep -v "Error: 100: Key not found|Cannot sync with the cluster" | sed -e 's/[\/&]/\\&/g')


sed -i -e "s/SYSLOG_S3_BUCKET/${SYSLOG_S3_BUCKET}/g" $LOGSTASH_CONFIG
sed -i -e "s/SYSLOG_S3_REGION/${SYSLOG_S3_REGION}/g" $LOGSTASH_CONFIG
sed -i -e "s/SYSLOG_S3_ACCESS_KEY/${SYSLOG_S3_ACCESS_KEY}/g" $LOGSTASH_CONFIG
sed -i -e "s/SYSLOG_S3_SECRET_KEY/${SYSLOG_S3_SECRET_KEY}/g" $LOGSTASH_CONFIG

export JAVA_HOME="/usr/lib/jvm/jre-1.7.0-openjdk.x86_64"
export JAVACMD="${JAVA_HOME}/bin/java"

/logstash-1.4.0/bin/logstash agent -f /logstash.conf

