#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
SERVICE_NAME=$(basename $SCRIPT_DIR)

rm /service/$SERVICE_NAME
kill $(pgrep -f 'supervise $SERVICE_NAME')
chmod a-x $SCRIPT_DIR/service/run
./restart.sh

# remove entry from rc.local
filename=/data/rc.local
grep -v $SERVICE_NAME $filename > $filename.temp
mv $filename.temp $filename
chmod +x $filename
