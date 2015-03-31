#!/bin/bash
X="aaa"
echo "x is $X"
echo 'x is $X' #单引号不展开变量
Y=""
if [ -n "$Y"]; then #-n检查变量是否为非空
  echo "Y is empty"
fi

P="pwd"
$P #执行pwd

Z="z value"
a="a value"
echo "xyz${Z}abc" #{}保护变量，防止变量识别错误

if [ -e "${HOME}/.gitconfig" ]; then #判断是否存在文件
  echo "you have a .gitconfig file" 
  if [ -L "${HOME}/.gitconfig" ]; then #判断是否是快捷方式
    echo "it's a symbolic link"
  elif [ -f "${HOME}/.gitconfig" ]; then #判断是否是正常文件
    echo "it's a regular file"
  fi
else
  echo "you have no .gitconfig file"
fi

for X in * #*代表当前目录所有文件及文件夹
do
  echo $X
done

X=0
while [ $X -le 5 ]
do
  echo $X
  X=$((X+1))
done


