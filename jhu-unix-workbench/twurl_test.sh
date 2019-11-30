#!/usr/bin/env bash
tname="realdonaldtrump"
lie_id=$(twurl "/1.1/statuses/user_timeline.json?screen_name=$tname&count=1" | jq -r '.[0].id_str' )
lie=$(twurl "/1.1/statuses/user_timeline.json?screen_name=$tname&count=1" | jq -r '.[0].text' )
lie_length=$(twurl "/1.1/statuses/user_timeline.json?screen_name=$tname&count=1" | jq '.[0].text | length ')
echo $lie_id, $lie, $lie_length, $tname

random=$(( $RANDOM % 2 ))
if [[ $random -eq 0 ]]
then
	#echo  -d "status=LIES!&in_reply_to_status_id=$lie_id&auto_populate_reply_metadata=true" /1.1/statuses/update.json

	twurl -d "status=LIES!&in_reply_to_status_id=$lie_id&auto_populate_reply_metadata=true" /1.1/statuses/update.json
else
	#echo  -d "status=OK BOOMER.&in_reply_to_status_id=$lie_id&auto_populate_reply_metadata=true" /1.1/statuses/update.json

	twurl -d "status=OK BOOMER.&in_reply_to_status_id=$lie_id&auto_populate_reply_metadata=true" /1.1/statuses/update.json
fi


