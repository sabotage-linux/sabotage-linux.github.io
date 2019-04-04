#!/bin/sh
. ./config.sh
n=$1

exec < $n/src.txt

read dummy title
read dummy pub
test "${n#[1-9]}" = $n || pub=${pub:-Unpublished}

printf '<html><head><title>%s - %s</title>\n' "$BLOGNAME" "$title"
cat head.inc

printf '<div class="article"><h2>%s</h2>\n\n' "$title"
printf '<div class="pub">%s</div>\n' "$pub"
perl ./Markdown.pl
printf '</div>\n'

false && :
cat <<EOF
<div id="disqus_thread">
<a name="comments"></a>
<noscript>
</noscript>
</div>

<script type="text/javascript">
var disqus_shortname = 'ewontfix';
var disqus_identifier = '$n';
var disqus_title = '$n';
(function() { var dsq = document.createElement('script');
dsq.type = 'text/javascript'; dsq.async = true;
dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
(document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
})();
</script>

EOF

cat foot.inc
