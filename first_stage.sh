#!/bin/bash

:'
This File is supposed to append data of the links corresponding to each movie to the subs_urls file, 
which will then go on to remove duplicate links retrieved. The links are going to be obtained by using Regex
on the webpage html of the ytssub website, it will use curl to perform a search of a particular movie, and then
go on to search for the first link that will appear.
'

for i in $(tail -8400 all_movies1.txt);
do
	echo $i
	# The "a" variable contains the movie name including the year where it was released
	a=$(curl -L "https://ytssub.com/search?s=$i"|grep -Eo "https://ytssub.com/movie-subtitles/\S+"|sed -e "s/\"//")
	
	:' At times, even though the release date is right the movie can still not be found
	This might require the use of another variable "c" to try and catch the movie either way
	In case this results in getting the wrong movie, this will be corrected on the Jupyter Notebook'
	
	c=$(echo $i |sed -e "s/[0-9]\+$//")
	echo $c
	second_try=$(curl -L "https://ytssub.com/search?s=$c"|grep -Eo "https://ytssub.com/movie-subtitles/\S+"|sed -e "s/\"//")

	b=$(curl -L "$a?lang=english"|grep -Eo "https://ytssub.com/subtitles/\S+"|head -1)
	e=$(curl -L "$second_try?lang=english"|grep -Eo "https://ytssub.com/subtitles/\S+"|head -1)
	
	echo $b
	echo $e
	
	# Finally appending the data to the files	
	echo $b >> subs_urls.txt;
	echo $e >> subs_urls.txt;
done

sort subs_urls.txt -r|uniq > subtitles_test.txt
