#!/bin/bash

ssh jerrington.me bash <<EOF
sudo su-mcallister
cd mcallister
git pull
sudo systemctl stop mcallister-server
make $@
sudo systemctl start mcallister-server
sudo systemctl status mcallister-server
EOF
