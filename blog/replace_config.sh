#!/bin/sh
. ./config.sh
cat "$1" > "$2"
for x in DOCROOT BLOGNAME ; do
	eval val=\${$x}
	sed -i "s,@$x@,$val,g" "$2"
done
