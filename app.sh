#!/bin/sh

CPU=`grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}'`
RAM=$(awk '{ printf "%.2f", $2/1024/1024 ; exit}' /proc/meminfo)
HDD=`df -lh | awk '{if ($6 == "/") { print $5 }}' | head -1 | cut -d'%' -f1`

jq . << EOF
{
    "CPU usage": "$CPU",
    "RAM all": "$RAM Gb",
    "HDD usage": "$HDD%",
    "kernel_version": "$(uname -r)",
    "operating_system": "$(awk '$1 == "NAME"{printf "%s ", $3 } $1 == "VERSION" {print $3}' FS=[=\"] /etc/os-release)",
    "os_architecture": "$(arch)"
}
EOF
