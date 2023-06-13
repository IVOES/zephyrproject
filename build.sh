#!/usr/bin/env bash

compile() {
  APP_DIR=$1
  BOARD=$(grep ':board:' $APP_DIR/README.rst | awk '{ print $2 }')
  west build -p always $APP_DIR -b $BOARD
}

APP_ROOT_DIR=zephyr/samples/
APP_DIRS=$(find $APP_ROOT_DIR -type d -exec test -f '{}'/CMakeLists.txt \; -print)
for app in $APP_DIRS; do
  timeout 10m compile $app
done
