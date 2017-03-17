#!/bin/bash
set -e
BASE_DIR=/root/code/huijin
rm -rf /root/.m2/repository/com/hetrone
cd ${BASE_DIR}/huijin-core
echo -e "deploy core \n"
git fetch && git merge origin/master
mvn clean deploy -U -Dmaven.test.skip=true
for project in ${BASE_DIR}/*
do
  echo "before git fetch ${project}"
  cd ${project}
  git fetch && git merge origin/master
  echo "after git fetch ${project}"
  #echo "git pull ${project}"
  for subDir in ${project}/*
  do
    if [[ "${subDir}" =~ client$ ]]; then 
      echo -e "\ndeploy ${project}\n"
      name="${subDir##*/}"
      cd ${project}
      #echo `pwd`
      mvn clean deploy -U -Dmaven.test.skip=true -pl ${name} -am
    fi
  done
done
