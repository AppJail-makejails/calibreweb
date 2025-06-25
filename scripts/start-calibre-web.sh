#!/bin/sh

CALIBREWEB_ADDRESS="${CALIBREWEB_ADDRESS:-0.0.0.0}"

set -ex
set -o pipefail

cd /calibre

daemon \
    -u calibre \
    -t "Web app for browsing, reading and downloading eBooks stored in a Calibre database" \
    -p /calibre/.pid \
    -o /calibre/.log \
        python src/cps.py
            -i "${CALIBREWEB_ADDRESS}" \
            -p /conf \
            -g /conf \
            -o /dev/stdout
