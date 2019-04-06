#!/bin/sh

. ./config.sh

cnt=0
root=https://${DOMAIN}

cat<<EOF
<?xml version="1.0"?>
<rss version="2.0">
<channel>
<title>$BLOGNAME</title>
<link>$root</link>
<description>$BLOGDESC</description>
<language>en</language>
EOF


echo [1-9]* | tr ' ' '\n' | sort -nr | while read n ; do {
read dummy title
read dummy pub
test "$pub" || continue

read title <<EOF
$(sed 's/&/&amp;/g
s/</\&lt;/g
s/>/\&gt;/g' <<EOF2
$title
EOF2
)
EOF

cat <<EOF
<item><title>$title</title>
<guid>${root}${DOCROOT}${n}</guid>
<pubDate>$pub</pubDate>
<description><![CDATA[
$({ head -n 15 ; echo ... ; } | perl ./Markdown.pl)
]]></description></item>
EOF

cnt=$(($cnt+1))
} <$n/src.txt
done

echo '</channel></rss>'

