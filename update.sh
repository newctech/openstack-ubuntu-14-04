#!/bin/bash

if [[ $# -eq 1 ]]; then
    git config --global user.name "zhangqingzheng"
    git config --global user.email "zhangqingzheng@qq.com"
    git remote rm origin
    git remote add origin git@github.com:JiYou/openstack.git
    tsocks git add .
    tsocks git commit -asm "\"$@\""
    tsocks git push origin
else
    echo "Useage: ./update.sh commit_msg"
fi
