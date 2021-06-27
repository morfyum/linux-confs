#!/bin/bash

serverList=(
	"192.168.1.1"
	"192.168.1.2"
	"192.168.1.3"
	"192.168.1.4"
	"192.168.1.4"
)
hostName=(
	"feri_pc"
	"jani_pc"
	"jozsi_pc"
	"geza_pc"
	"laci_pc"	
)
remoteUser=(
	"aaa"
	"bbb"
	"ccc"
	"ddd"
	"eee"
)

serverNum=0
for machine in ${serverList[@]}
do
	echo -e "-------------------------------------------------------------------------"
	echo -e "# REMOTE WORK: $((serverNum+1)) | HOST: $machine | USER: ${remoteUser[$serverNum]} | HOSTNAME: ${hostName[$serverNum]}"
	echo -e "-------------------------------------------------------------------------"
	ping -c 1 -W 3 ${serverList[$serverNum]}

	serverNum=$((serverNum+1))
done
