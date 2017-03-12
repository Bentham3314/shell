#!/bin/sh

###
#
# chmod 755
# chown root:root
#
###


PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

_webhook=""
_chan=""
_bname=""
_sub=""
_tmp_mess=/tmp/notif.tmp


_trap=`while read line; do echo ${line}; done`

_src=`echo $_trap | awk -F[ '/UDP: \[.+\]/ {print $2}' | cut -d] -f1`

echo -en "${_sub}\n\`\`\`src=${_src}\n${_trap}\`\`\`\n" | tr '\n' '\r' | sed 's/'"$(printf '\r')"'/\\n/g'  >| ${_tmp_mess}

_mess=`cat ${_tmp_mess}`

curl -sS -XPOST --data-urlencode "payload={\"channel\": \"${_chan}\", \"username\": \"${_bname}\", \"text\": \"${_mess}\" }" ${_webhook} >/dev/null

