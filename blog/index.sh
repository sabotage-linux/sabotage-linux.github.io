#!/bin/sh
. ./config.sh
cnt=0
lim=10

cat <<EOF
<html><head><title>$BLOGNAME</title>
<link rel="alternate" href="${DOCROOT}feed.rss" type="application/rss+xml" title="$BLOGNAME RSS">
EOF

cat head.inc


echo [1-9]* | tr ' ' '\n' | sort -nr | while read n ; do {
read dummy title
read dummy pub
test "$pub" || continue

if [ "$cnt" -lt "$lim" ] ; then
printf '<div class="article"><h2><a href="%s">%s</a></h2>\n\n' $n "$title"
printf '<div class="pub">%s</div>\n' "$pub"
perl ./Markdown.pl
printf '<p><a href="%s/#comments">Post or read comments...</a></p></div>\n' $n
else
[ "$cnt" -eq "$lim" ] && cat <<EOF
<div class="older">
<h2>Earlier posts</h2>
<ul>
EOF
printf '<li><a href="%s">%s</a></li>\n' $n "$title"
fi
cnt=$(($cnt+1))
} <$n/src.txt
done


[ "$cnt" -ge "$lim" ] &&  printf '</ul></div>\n'


cat foot.inc
