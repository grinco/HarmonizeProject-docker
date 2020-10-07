#!/bin/bash
LAST='null'
while [ true ]; do
  SYNC=`pigs r 14`
  if [ $LAST == $SYNC ]; then
     sleep 1 
  elif [ $SYNC -eq 0 ]; then
     echo "Stopping HUE Sync"
     docker stop harmonizeproject
  else
     echo "Starting HUE Sync"
     docker run -d --rm -t --name harmonizeproject --device=/dev/video0 -e ARGS="-v -g4" -v ~/client.json:/app/client.json grinco/harmonizeproject:armhf 
  fi
  LAST=$SYNC
done
