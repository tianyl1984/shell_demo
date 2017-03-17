#!/bin/bash
set -e
BASE_DIR=/root/code/huijin
CUR_DATE=`date +%Y%m%d`
SINGLE_JARS=(charging-quartz-0.0.1-SNAPSHOT.jar debt-error-comp-0.0.1-SNAPSHOT.jar loanpayment-quartz-0.0.1-SNAPSHOT.jar)
DISTRIBUTED_JARS=(admin-web-0.0.1-SNAPSHOT.jar apigateway-0.0.1-SNAPSHOT.jar base-biz-0.0.1-SNAPSHOT.jar charging-biz-0.0.1-SNAPSHOT.jar debt-biz-0.0.1-SNAPSHOT.jar loanpayment-biz-0.0.1-SNAPSHOT.jar)
DIST_DIR=/root/code/huijin-jar-${CUR_DATE}/
SINGLE_DIR=${DIST_DIR}/单节点
rm -rf ${SINGLE_DIR}
mkdir -p ${SINGLE_DIR}
rm -rf /root/.m2/repository/com/hetrone
for project in ${BASE_DIR}/*
do
  cd ${project}
  echo -e "\n package ${project} \n"
  git fetch && git merge origin/master
  mvn clean package -U -Dmaven.test.skip=true
done
echo "----------finish package-----------"
function findJar() {
  for file in $1/*
  do
    if test -d $file; then
      findJar ${file}
    else
      name=${file##*/}
      for jar in ${SINGLE_JARS[@]}
      do
        if [ "${name}" = "${jar}" ]; then
          echo "copy jar ${file}"
          cp ${file} ${SINGLE_DIR}/${jar%-*}.jar
        fi
      done
      for jar in ${DISTRIBUTED_JARS[@]}
      do
        if [ "${name}" = "${jar}" ]; then
          echo "copy jar ${file}"
          cp ${file} ${DIST_DIR}/${jar%-*}.jar
        fi
      done
     # echo $file
    fi
  done
}
findJar ${BASE_DIR}
echo "-----------finish copy--------------"
cd ${BASE_DIR}/../
zip -r huijin-jar-${CUR_DATE}.zip huijin-jar-${CUR_DATE}/
echo "-----------finish zip---------------"
cp huijin-jar-${CUR_DATE}.zip ./bak/
