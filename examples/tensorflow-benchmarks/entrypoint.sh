#!/bin/bash

SSH_MNT=${SSH_MNT:-/mnt/ssh}
if [ -d "$SSH_MNT" ]; then
  mkdir -p $HOME/.ssh
  cp /mnt/ssh/* $HOME/.ssh
  chmod 600 $HOME/.ssh
fi

exec "$@"