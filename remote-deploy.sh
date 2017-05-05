#!/bin/bash

ssh jerrington.me bash <<EOF
sudo su-mcallister
cd mcallister
git pull
make $@
EOF
