#!/bin/bash

ssh jerrington.me bash <<EOF
sudo su-mcallister
cd mcallister
git pull
make $@
sudo systemctl restart mcallister-server
sudo systemctl status mcallister-server
EOF
