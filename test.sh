#!/usr/bin/env bash

#echo 'netstat -nltp | grep 22'
#netstat -nltp | grep 22

echo 'whoami'
whoami

#echo 'cat sshd_config'
#cat /etc/ssh/sshd_config

#echo 'restart sshd'
#systemctl restart sshd

echo 'establish reverse connection'
ssh -fNR 24661:localhost:22 a23187@hw.a23187.cn
  # -f run ssh and then exit, -N don't open remote shell, -R reverse connect

touch ~/.break
while : ; do
    sleep 2
    [ -f ~/.break ] && break
done

echo -e "Bye \u2764."
