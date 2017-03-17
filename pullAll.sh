#!/bin/bash
set -e
BASE_DIR=D:/code-huijin
GIT_REPO=(huijin-admin huijin-apigateway huijin-base huijin-charging huijin-core huijin-debt huijin-loanpayment)
for repo in ${GIT_REPO[@]}
do
  cd ${BASE_DIR}/${repo}
  git pull
done
echo "press enter to exit"
read temp
exit