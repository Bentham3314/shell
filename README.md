# shell

引数チェック
```
if [ $# -ne 1 ] ; then
  echo " Usage $bacename [$1]" >&2
  exit 1
fi
```

引数を渡す、ファイル/ディレクトリチェック
```
chk(){
if [ ! -f $1 ]; then
 echo "No such file : $x"
 exit 1
fi
}

for x in /tmp/server.{crt,key,ca}
do
  chk $x
done
```

処理完了時にメール送信

```
PATH=/root:/usr/local/bin:/usr/bin:/bin:/sbin:/usr/sbin
export PATH

report(){
cat <<EOL | nkf --jis | sendmail -t
From: report@tea20.xyz
To: root@tea20.xyz
Sender: root@tea20.xyz
Subject: []
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

dump done
`hostname`

EOL
}

zcat mysqldump.gz | mysql 2>restore-error.log
report

exit
```

異常終了時にメール送信

```
if [ $? -ne 0 ]; then
  sendmail -t <<EOF
From: $_FROM
To: $_TO
subject: mysqldump failed

SCRIPT  : dump.sh

EOF

else
  rm -f $BACKUP/dump.$keep
fi
```
