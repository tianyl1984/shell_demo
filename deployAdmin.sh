#!/bin/bash
set -e
CODE_DIR=/root/huijin-admin
TARGET_DIR=/root/huijin-admin/admin-web/target
JAR_NAME=admin-web
function chkerr()
{
  if [ $? -ne 0 ]
  then
    echo $1
    exit 1
  fi
}

cd $CODE_DIR
chkerr "path not exists"
git pull
chkerr "git pull error"
mvn clean deploy -U -Dmaven.test.skip=true
chkerr "mvn error"
cd $TARGET_DIR
chkerr "no target dir"
jarFile="${JAR_NAME}-0.0.1-SNAPSHOT.jar"
if [ ! -f "$jarFile" ]
then
  echo "no jar file ${JAR_NAME}"
  exit 1
fi
curDate=`date '+%m%d'`
cp "$jarFile" /root/bin/${JAR_NAME}-$curDate.jar
cp "$jarFile" /root/bin/${JAR_NAME}.jar
cd /root/bin/
echo "stop..."
PID=$(ps -ef | grep java.*\.jar | grep ${JAR_NAME}  | grep -v grep | awk '{ print $2 }')
if [ -z "$PID" ]
then
    echo "already stopped"
else
    kill $PID
fi
sleep 5
echo "start..."
nohup java -Xmx512m -Xms128m -XX:MaxPermSize=128m -jar ${JAR_NAME}.jar --spring.profiles.active=test $ENV_SPRING_BOOT_APPEND >> /dev/null 2>&1 &
echo "success"
exit 0
