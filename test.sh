#!/usr/bin/env bash

echo 'whoami'
whoami

echo 'updating /etc/ssh/sshd_config ...'
cat >> /etc/ssh/sshd_config << EOF
PubkeyAuthentication yes
AuthorizedKeysFile .ssh/authorized_keys
EOF

echo 'cat sshd_config'
tail /etc/ssh/sshd_config

echo 'establish reverse connection'
sshpass -p $SSHPASS ssh -o 'StrictHostKeyChecking=accept-new' -fNR 24661:localhost:22 a23187@hw.a23187.cn
  # -f run ssh and then exit, -N don't open remote shell, -R reverse connect
echo -n 'return status: '
echo $?

echo 'sleep 1min'
sleep $((1*60))

touch ~/.break
while : ; do
    sleep 2
    [ -f ~/.break ] && break
done

echo -e "Bye \u2764"
