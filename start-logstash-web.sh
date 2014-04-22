#!/bin/bash
export JAVA_HOME="/usr/lib/jvm/java-1.7.0-openjdk.x86_64"
export JAVACMD="${JAVA_HOME}/bin/java"
/logstash-1.4.0/bin/logstash web
