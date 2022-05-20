#!/bin/bash

for i in $(cat subtitles_test.txt);
do
	a=$(echo $i|sed "s/\"//")
	b=$(curl -L $a| grep -Eo "https://ytssub.com/subtitle-download/\S+"|sed -e "s/\"//")
	c=$(curl -L $b| grep -Eo "https://ytssub.net/file/data/\S+"|sed -e "s/\"//")
	get $c
done




