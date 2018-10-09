#!/bin/bash

SCRIPT_DIR=`cd $(dirname $(readlink -f $0)); pwd`
UWSGI_INI="`dirname $SCRIPT_DIR`/etc/uwsgi.ini"

# Setup Django
if [[ ! -d "$WWW_DIR/mysite" ]]; then
	cd $WWW_DIR
	django-admin startproject mysite
fi
sed -i -e "s:ALLOWED_HOSTS = .*:ALLOWED_HOSTS = ['$DOCKER_HOSTNAME']:" $WWW_DIR/mysite/mysite/settings.py

# Start uWSGI
echo "[`hostname -s`] Started"
uwsgi --ini $UWSGI_INI \
      --chdir=$WWW_DIR/mysite
