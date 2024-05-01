#!/bin/bash

env > /tmp/env-pre
source /root/esp-idf/export.sh
env > /tmp/env-post

echo -e "\n# ESP-IDF" >> ~/.bashrc
diff /tmp/env-pre /tmp/env-post | grep ">" | sed 's/> //' | sed 's/^/export /' >> ~/.bashrc

rm /tmp/env-pre /tmp/env-post
