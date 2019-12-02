echo "start program"

if [[ $1 -eq 4 ]]
then
  echo "You entered $1"
elif [[ $1 -eq 44 ]]
then
  echo "$1 is doubly good."
elif [[ -z $1 ]]
then
  echo "not saying much, eh?"
else 
  echo "You entered $1, not what I was expecting."
fi

echo "End Program"
