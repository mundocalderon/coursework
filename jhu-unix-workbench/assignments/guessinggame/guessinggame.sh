num=$(find . -type f -maxdepth 1 | wc -l)
guess=0

while [[ $num -ne $guess ]]
do
	echo "guess the number files in this directory!"	
	read guess
	if [[ $guess -gt $num ]]
	then
		echo "Too High"
	elif [[ $guess -lt $num ]]; then
		echo "Too Low"
	fi
done

echo "You got it! $guess"
