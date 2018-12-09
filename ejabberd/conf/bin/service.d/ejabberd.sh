#!/usr/bin/env bash

if [[ -z "$SERVICE_EJABBERD_OPTS" ]]; then SERVICE_EJABBERD_OPTS=""; fi

source /opt/docker/bin/config.sh

includeScriptDir "/opt/docker/bin/service.d/ejabberd.d/"

function onStop
{
    echo -e "in trap: exec ejabberdctl stop"
    ejabberdctl stop
}

trap "onStop" 2 3 15

exec ejabberdctl $SERVICE_EJABBERD_OPTS foreground &

wait
