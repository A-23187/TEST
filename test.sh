#!/usr/bin/env bash

LOCAL_USER=${LOCAL_USER:-debugger}
LOCAL_USER_PWD=${LOCAL_USER_PWD:-12345}
PORT=${PORT:-23187}

echo "adding a new local user: $LOCAL_USER ..."
sudo useradd -G sudo -s /bin/bash -m $LOCAL_USER

echo "setting $LOCAL_USER's password ..."
echo -e "$LOCAL_USER_PWD\n$LOCAL_USER_PWD" | sudo passwd $LOCAL_USER

echo "connect to $REMOTE_USER@$REMOTE_HOST ..."
if [ "$SSH_KEY" != "" ]; then
    # connect using private key
    echo $SSH_KEY > ssh_key
    chmod 600 ssh_key
    ssh -i ssh_key -o StrictHostKeyChecking=accept-new \
        -fNR $PORT:localhost:22 $REMOTE_USER@$REMOTE_HOST
    rm ssh_key
else
    # connect using password
    sshpass -p $SSH_PWD ssh -o StrictHostKeyChecking=accept-new \
        -fNR $PORT:localhost:22 $REMOTE_USER@$REMOTE_HOST
fi

echo "to connect back by running 'ssh $LOCAL_USER@localhost -p $PORT'"
echo "and 'touch /home/$LOCAL_USER/.exit' to exit after connecting."
while : ; do
    sleep 1
    [ -f /home/$LOCAL_USER/.exit ] && break
done
echo -e "Bye \u2764"
