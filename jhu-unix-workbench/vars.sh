echo "Script arguments: $@"
echo "First arg: $1. Second arg: $2."
echo "Number of arguments: $#"
echo "before assignment"
math_lines=$(cat math.sh | wc -l)
echo "after assignment"
echo "$math_lines"
var1=2
var2=4
echo $var2
ans=$(($1*$#))
echo $ans

num=$[var1+var2]
echo "$num"
