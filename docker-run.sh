#!/bin/bash

[ "${USER}" == "aosp" ] && exit 0

dirx="${PWD:${#HOME}}"		# remove /ssd2/workspace/erwin-hud/hud_bsp
dirx=${dirx#/}			# remove /
ssdx="${dirx:0:4}"
name=$(echo "$dirx" | sed 's/\//./g')

docker run -v $HOME:/mnt/aosp -it --rm --name $name erwinchang/sp8388 /bin/bash
