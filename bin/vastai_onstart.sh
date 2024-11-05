#!/bin/bash

# Expected to run on vastai instance start.

env | grep _ >> /etc/environment  # To use env for non shell apps
echo 'starting up'

# git config --global credential.helper 'cache --timeout=172800'  # 48 hours
# git config --global  --add user.name ArtyomK 
# git config --global  --add user.email artyomkarpov@gmail.com
 

