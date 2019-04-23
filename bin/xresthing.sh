#!/usr/bin/env bash

colours="$(xrdb -query | \
	grep \*color | \
	sed -e 's/\*//' -e 's/color//' -e 's/\://' -e 's/#//' | \
	sort -n | \
	awk '{print $2}' | \
	sed -e 's/.\{2\}/&\//g' -e 's/\/$//'\
	-e 's/^/rgb\:/')"

echo "$colours" | sed -e "s/^/echo -en '\\\\033\]4;   /" -e "s/$/\\\\033\\\\\\\\\'/" | \
	awk '{print $1 " " $2 " " $3 NR-1 ";" $4}' > /tmp/colours.sh 
chmod a+x /tmp/colours.sh

xrdb -query | grep \*background | \
	sed -e 's/#//' | \
	awk '{print $2}' | \
	sed -e 's/.\{2\}/&\//g' -e 's/\/$//' -e 's/^/rgb\:/' | \
	sed -e "s/^/echo -en \'\\\\033\]4;256;/" -e "s/$/\\\\033\\\\\\\\\'/"  >> /tmp/colours.sh


xrdb -query | grep \*foreground | \
	sed -e 's/#//' | \
	awk '{print $2}' | \
	sed -e 's/.\{2\}/&\//g' -e 's/\/$//' -e 's/^/rgb\:/' | \
	sed -e "s/^/echo -en \'\\\\033\]4;257;/" -e "s/$/\\\\033\\\\\\\\\'/"  >> /tmp/colours.sh
