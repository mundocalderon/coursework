echo "Hi, hello."

if [[ -z $1 ]]
then
  echo "that's a bit rude, why not say anything?"
  read prompt
  if [[ $prompt =~ ^[A-Z] ]]
  then
    echo "how proper"
  else
    echo "could be proper, but what I got is $prompt"
  fi 
else
  if [[ $1 =~ ^[A-Z] ]]
  then
    echo "Oh you fancy."
  else
    echo "That's what I thought."
  fi
fi

today=$(date +%A)
echo "also today is $today"
