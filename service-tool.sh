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
HEHE_DOWNLOAD_URL="http://get.hehecloud.com"

export DEISCTL_UNITS=$HEHE_UNIT_DIR_PATH

# create path
function create_path {
	/usr/bin/mkdir -p $HEHE_UNIT_DIR_PATH
}


# download k8s unit
function download_k8s_units {
	/usr/bin/curl -sSL --fail --retry 7 --retry-delay 2 -o ${HEHE_UNIT_DIR_PATH}/deis-kube-apiserver.service ${HEHE_DOWNLOAD_URL}/units/k8s/deis-kube-apiserver.service && \
	/usr/bin/curl -sSL --fail --retry 7 --retry-delay 2 -o ${HEHE_UNIT_DIR_PATH}/deis-kube-controller-manager.service ${HEHE_DOWNLOAD_URL}/units/k8s/deis-kube-controller-manager.service && \
	/usr/bin/curl -sSL --fail --retry 7 --retry-delay 2 -o ${HEHE_UNIT_DIR_PATH}/deis-kube-kubelet.service ${HEHE_DOWNLOAD_URL}/units/k8s/deis-kube-kubelet.service && \
	/usr/bin/curl -sSL --fail --retry 7 --retry-delay 2 -o ${HEHE_UNIT_DIR_PATH}/deis-kube-proxy.service ${HEHE_DOWNLOAD_URL}/units/k8s/deis-kube-proxy.service && \
	/usr/bin/curl -sSL --fail --retry 7 --retry-delay 2 -o ${HEHE_UNIT_DIR_PATH}/deis-kube-scheduler.service ${HEHE_DOWNLOAD_URL}/units/k8s/deis-kube-scheduler.service
}

# download unit
function download_unit {
	create_path
	if [[ "$HEHE_SERVICE_NAME" == "k8s" ]]
	then
		download_k8s_units
	else
		/usr/bin/curl -sSL --fail --retry 7 --retry-delay 2 -o ${HEHE_UNIT_FILE_PATH} ${HEHE_DOWNLOAD_URL}/units/${HEHE_UNIT}
	fi
}

# install
function install {
	# if [ ! -f $HEHE_UNIT_FILE_PATH ]; then
	#		download_unit
	# fi
	download_unit
	/opt/bin/deisctl install $HEHE_SERVICE_NAME
}

# start
function start {
	install
	/opt/bin/deisctl start $HEHE_SERVICE_NAME
}

# stop
function stop {
	/opt/bin/deisctl stop $HEHE_SERVICE_NAME
}

# uninstall
function uninstall {
	stop
	/opt/bin/deisctl uninstall $HEHE_SERVICE_NAME
	if [[ "$HEHE_SERVICE_NAME" != "k8s" ]]
	then
		rm -rf $HEHE_UNIT_FILE_PATH
	fi
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
	download)
		download
		;;
	*)
	echo "Usage: $0 <service name> {start|stop|restart|install|uninstall|download}"
	exit -1
esac
