#!/bin/bash
export JAVA_HOME="/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.51.x86_64/jre"
export JAVACMD="${JAVA_HOME}/bin/java"
/logstash-1.4.0/bin/logstash web
