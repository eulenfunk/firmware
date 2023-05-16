#!/bin/bash

LUA="/usr/bin/lua"

_log_ok ()
{
    echo -e "\e[32m${1}\e[0m"
}

_log_err ()
{
    echo -e "\e[31m\e[1m${@}\e[0m"
}


for file in templates/*; do
    echo Checke ${file}/site.conf
    export GLUON_SITEDIR="${file}"
    json=$(${LUA} tests/site_config.lua)
    rc=$?

    if [ "$rc" == "1" ]; then
        _log_err "Konnte site.conf für ${file} nicht einlesen. Fehler:"
        _log_err $json
    else
        _log_ok "site.conf in Ordnung."
        #echo $json | jq
    fi
    echo "------------------------------------------------------------------------------------------------------------------"
done