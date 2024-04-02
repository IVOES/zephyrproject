#!/usr/bin/env bash

compile() {
  APP_DIR=$1
  echo -e "\e[34mAPP_DIR:$APP_DIR\e[0m"

  BOARD=$(grep ':board:' $APP_DIR/README.rst | grep -v '<' | awk '{ print $2 }' | head -n 1)
  if [ -z "$BOARD" ]; then
    BOARD=qemu_cortex_m3
  fi
  echo -e "\e[34mBOARD:$BOARD\e[0m"

  timeout 10m west build -p always $APP_DIR -b $BOARD
  rm -rf build
}

APP_ROOT_DIR=zephyr/samples/
APP_DIRS=$(find $APP_ROOT_DIR -type d -exec test -f '{}'/CMakeLists.txt \; -print)
for app in $APP_DIRS; do
  compile $app
done

exit 0
