#!/bin/bash
BASE_DIRS=(D:/code-huijin D:/code-xiaodai)
MSG=""
for dir in ${BASE_DIRS[@]}
do
	for file in $dir/*
	do
		if test  -d $file/.git
		then
			cd $file
			echo "start fetch $file"
			#git status
			git fetch
			t=`git status | grep 'use "git pull"'`
			if [ -n "$t" ]; then
				echo $t
				MSG="${MSG}${file##*/} \n"
			fi
			echo "end fetch $file"
		fi
	done
done
echo "end all"
echo -e "press enter to exit\n\n"
echo -e $MSG
read temp
exit