#!/usr/bin/env bash

set -eo pipefail

[[ $DEBUG ]] && set -x


if [ -z "$1" ]; then
	echo "missing required params #1"
	exit -1
fi

if [ -z "$2" ]; then
	echo "missing required params #2"
	exit -1
fi


HEHE_SERVICE_NAME=$1
HEHE_UNIT="deis-${HEHE_SERVICE_NAME}.service"
HEHE_UNIT_DIR_PATH="/var/lib/deis/units"
HEHE_UNIT_FILE_PATH=${HEHE_UNIT_DIR_PATH}/${HEHE_UNIT}

export DEISCTL_UNITS=$HEHE_UNIT_DIR_PATH

# create path
function create_path {
	/usr/bin/mkdir -p $HEHE_UNIT_DIR_PATH
}

# download unit
function download_unit {
	create_path
	/usr/bin/curl -sSL --retry 7 --retry-delay 2 -o ${HEHE_UNIT_FILE_PATH} http://get.hehecloud.com/units/${HEHE_UNIT}
}

# install
function install {
	download_unit
	/opt/bin/deisctl install $HEHE_SERVICE_NAME
}

# uninstall
function uninstall {
	/opt/bin/deisctl uninstall $HEHE_SERVICE_NAME
	rm -rf $HEHE_UNIT_FILE_PATH
}


# start
function start {
	/opt/bin/deisctl start $HEHE_SERVICE_NAME
}


# stop
function stop {
	/opt/bin/deisctl stop $HEHE_SERVICE_NAME
}


# restart
function restart {
	/opt/bin/deisctl restart $HEHE_SERVICE_NAME
}


case "$2" in
	start)
		start
		;;
	stop)
		stop
		;;
	install)
		install
		;;
	uninstall)
		uninstall
		;;
	restart)
		restart
		;;
	*)
	echo $"Usage: $0 <service name> {start|stop|restart|install|uninstall}"
	exit -1
esac
