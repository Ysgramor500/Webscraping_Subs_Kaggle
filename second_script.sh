#!/bin/bash

: 'This file will make use of all the links acquired on the first stage and stored on the subtitles_test.txt file
to figure out what is the true download link and then go on to download the zip files for each one of those'

for i in $(cat subtitles_test.txt);
do
	a=$(echo $i|sed "s/\"//")
	b=$(curl -L $a| grep -Eo "https://ytssub.com/subtitle-download/\S+"|sed -e "s/\"//")
	c=$(curl -L $b| grep -Eo "https://ytssub.net/file/data/\S+"|sed -e "s/\"//")
	wget $c
done

# Now it's time to finally unzip the files...

for i in $(ls zip); 
do  
	unzip $i
done


