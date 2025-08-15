#!/bin/sh

# Set default PORT if not provided
export PORT=${PORT:-80}

# Substitute PORT in nginx config
envsubst '${PORT}' < /etc/nginx/nginx.conf > /tmp/nginx.conf
mv /tmp/nginx.conf /etc/nginx/nginx.conf

roco > /usr/share/nginx/html/papermerge-runtime-config.js
exec /usr/bin/supervisord
