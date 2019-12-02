all: guessinggame.sh
	echo "# This project is named The Guessing Game" >> README.md
	echo $(shell date) >> README.md
	echo "This script has the following number of lines:" >> README.md
	wc -l < guessinggame.sh >> README.md

clean: 
	rm README.md
