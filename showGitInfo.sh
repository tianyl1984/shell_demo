#!/bin/bash
set -e
BASE_DIR=D:/code-huijin
GIT_REPO=(huijin-admin huijin-apigateway huijin-base huijin-charging huijin-core huijin-debt huijin-loanpayment)
for repo in ${GIT_REPO[@]}
do
  cd ${BASE_DIR}/${repo}
  #echo -e "${repo}          \t\t`git rev-parse --abbrev-ref HEAD`"
  printf "%-20s %-20s\n" ${repo} `git rev-parse --abbrev-ref HEAD`
done
read temp
exit