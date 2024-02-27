#!/bin/sh

sketchybar --add item appname center            \
           --set appname                        \
             icon="󰣆"                           \
             script=${PLUGINS_DIR}/appname.sh   \
           --subscribe appname                  \
             front_app_switched                 \
