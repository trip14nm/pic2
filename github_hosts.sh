#!/bin/bash

CONTENT="# GitHub START
20.205.243.166 gist.github.com
20.205.243.166 github.com
185.199.109.153 assets-cdn.github.com
151.101.129.194 github.global.ssl.fastly.net
185.199.111.133 raw.githubusercontent.com
# GitHub END"

BACKUP_FILE="/etc/hosts.bak"

if [ "$EUID" -ne 0 ]; then
    echo "failed, are you root?"
    exit 1
fi

if [ ! -f "$BACKUP_FILE" ]; then
    cp /etc/hosts "$BACKUP_FILE"
    echo "backup hosts to $BACKUP_FILE。"
else
    echo "backup exists, skip"
fi

if grep -Fxq "$CONTENT" /etc/hosts; then
    echo "conetnt exists, nothing to do"
else
    echo "$CONTENT" >> /etc/hosts

    if [ $? -eq 0 ]; then
        echo "done"
    else
        echo "failed, are you root?"
    fi
fi
