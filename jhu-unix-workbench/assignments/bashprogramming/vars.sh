#!/usr/bin/env bash
# File: vars.sh

echo "Script arguments: $@"
echo "First arg: $1. Second arg: $2."
echo "Number of arguments: $#"


#bash vars.sh

## Script arguments:
## First arg: . Second arg: .
## Number of arguments: 0

#bash vars.sh red

## Script arguments: red
## First arg: red. Second arg: .
## Number of arguments: 1

#bash vars.sh red blue

## Script arguments: red blue
## First arg: red. Second arg: blue.
## Number of arguments: 2

#bash vars.sh red blue green

## Script arguments: red blue green
## First arg: red. Second arg: blue.
## Number of arguments: 3

echo "before assignment"
math_lines=$(cat math.sh | wc -l)
echo "after assignment"
echo "$math_lines"
var1=2
var2=4
echo $var2
ans=$(( $1 * $# ))
echo $ans

num=$[var1+var2]
echo "$num"

# [admin bashprogramming]$ bash vars.sh 2 2
# Script arguments: 2 2
# First arg: 2. Second arg: 2.
# Number of arguments: 2
# before assignment
# after assignment
#        5
# 4
# 4
# 6


var1="two"
var2="four"

echo $var1
echo $var2

echo $var1 $var2

two
four
two four

