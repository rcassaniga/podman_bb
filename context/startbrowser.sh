#!/bin/bash -xe

/usr/bin/dpkg -D10 -i /src/warsaw.deb
systemctl enable --now warsaw

cp /root/.Xauthority /home/user/.Xauthority
chown user:user /home/user/.Xauthority

runuser -l user -c "XAUTHORITY=/home/user/.Xauthority DISPLAY=:1 firefox --no-remote --new-instance https://seg.bb.com.br"

kill -SIGRTMIN+3 1

