#!/usr/bin/env bash

cat /etc/ssh/sshd_config
systemctl restart sshd
ssh -fNR 24661:localhost:22 a23187@hw.a23187.cn
  # -f run ssh and then exit, -N don't open remote shell, -R reverse connect

touch ~/.break
while : ; do
    sleep 2
    [ -f ~/.break ] && break
done

echo -e "Bye \u2764."
