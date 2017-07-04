#!/bin/sh

/usr/share/elasticsearch/bin/elasticsearch-systemd-pre-exec

/usr/share/elasticsearch/bin/elasticsearch -Epath.conf=/etc/elasticsearch/
