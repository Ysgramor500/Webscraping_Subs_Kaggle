#!/bin/bash


for i in $(tail -8400 all_movies1.txt);
do
	echo $i
	a=$(curl -L "https://ytssub.com/search?s=$i"|grep -Eo "https://ytssub.com/movie-subtitles/\S+"|sed -e "s/\"//")
	c=$(echo $i |sed -e "s/[0-9]\+$//")
	echo $c
	second_try=$(curl -L "https://ytssub.com/search?s=$c"|grep -Eo "https://ytssub.com/movie-subtitles/\S+"|sed -e "s/\"//")
	b=$(curl -L "$a?lang=english"|grep -Eo "https://ytssub.com/subtitles/\S+"|head -1)
	e=$(curl -L "$second_try?lang=english"|grep -Eo "https://ytssub.com/subtitles/\S+"|head -1)
	
	echo $b
	echo $e
	
	echo $b >> subs_urls.txt;
	echo $e >> subs_urls.txt;
done

sort subs_urls.txt -r|uniq > subtitles_test.txt
