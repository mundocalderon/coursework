#!/usr/bin/env bash

if [[ -e guestbook.md ]]
then
	echo "guestbook exists!"
	first_md5=$(md5 guestbook.md | awk '{ print $4 }')
	echo "guestbook md5 is $first_md5"
	compare_md5=$(curl -s https://raw.githubusercontent.com/seankross/the-unix-workbench/master/guestbook.md | md5 )
	echo "the online md5 is $compare_md5"
	if [[ $first_md5 == $compare_md5 ]]
	then
		echo "We have the most up-to-date guestbook!"
	else
		echo "There's been a change to the guestbook, let's see who signed it!"
		curl -O https://raw.githubusercontent.com/seankross/the-unix-workbench/master/guestbook.md
		tail -n 5 guestbook.md
	fi
else
	curl -O https://raw.githubusercontent.com/seankross/the-unix-workbench/master/guestbook.md
	tail -n 5 guestbook.md
fi