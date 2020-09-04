#!/usr/bin/env bash

echo "whoami: $(whoami)"

#echo 'updating /etc/ssh/sshd_config ...'
#sudo cat >> /etc/ssh/sshd_config << EOF
#PubkeyAuthentication yes
#AuthorizedKeysFile .ssh/authorized_keys
#EOF
#tail -2 /etc/ssh/sshd_config
#
#ls -l ~/.ssh/authorized_keys
#echo 'saving public key of the remote host'
#cat $REMOTE_PUBKEY >> ~/.ssh/authorized_keys
#tail -1 ~/.ssh/authorized_keys
#ls -l ~/.ssh/authorized_keys
#
#echo 'restarting sshd'
#sudo systemctl restart sshd

echo 'adding new user and setting password'
sudo useradd -G sudo -s bin/bash -m aaa
echo -e '123456\n123456' | sudo passwd aaa

echo 'establishing reverse connection'
sshpass -p $SSHPASS ssh -o 'StrictHostKeyChecking=accept-new' -fNR 24661:localhost:22 a23187@hw.a23187.cn
  # -f run ssh and then exit, -N don't open remote shell, -R reverse connect

echo 'sleep 1min'
sleep $((1*60))

touch ~/.break
while : ; do
    sleep 2
    [ -f ~/.break ] && break
done

echo -e "Bye \u2764"
