#!/usr/bin/env bash

if [ $# -ne 1 ] || [[ ! "$1" =~ ^https:\/\/dl.google.com\/(.+)\/GoogleMaps-[0-9].[0-9].[0-9].tar.gz ]];  then
  SCRIPT=$(basename $0)
  echo "Usage"
  echo "  $SCRIPT <repository name> <file path>"
  echo "    or "
  echo "  $SCRIPT (the url of the google maps ios sdk)"
  exit
fi

#------------------------
# Download the sdk file
#------------------------
ARIA2=$(which aria2c)
DOWNLOAD_URL="$1"
FILENAME=$(basename ${DOWNLOAD_URL})

if [ -z "work_dir" ]; then
  mkdir work_dir
fi
cd work_dir

if [ -z "${FILENAME}" ]; then
  if [ -z "${ARIA2}" ]; then
    CURL=$(which curl)
    if [ -z "${CURL}" ]; then
      echo "The curl command is required at least."
      exit 1
    fi

    echo " - Download the file using CURL"
    curl -L -G -r 5 ${DOWNLOAD_URL} > ${FILENAME}

    echo " - Download completed "

  else
    echo " - Download the file using aria2c"
    RESULT=$(aria2c --continue=true --console-log-level=error -k1M  -x 2 -s 2 --show-console-readout false ${DOWNLOAD_URL})

    IS_SUCCESS=$(echo "${RESULT}"|grep "download completed"|wc -l)
    if [ ${IS_SUCCESS} -eq 1 ]; then
      echo " - Download completed "
    else
      echo " - Download failed"
      cd ..
      rm -rf work_dir
      exit 0
    fi
  fi
fi

#------------------------
# Extract the archive file
#------------------------
tar -xf $FILENAME


cd ..
