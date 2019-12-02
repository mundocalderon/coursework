true && echo "true is true"
false && echo "false is false"

echo 1 && false && echo 3
echo -n 4 && true && echo  5

true || echo 6
false || echo 7


[[ 4 -gt 3 ]] && echo true || echo false
[[ 3 -gt 4 ]] && echo true || echo false
echo "does math.sh exist?"
[[ -e math.sh ]] && echo true || echo false


[[ rhythms =~ [aeiou] ]] && echo t || echo f
my_name=sean
[[ $my_name =~ ^s.+n$ ]] && echo t || echo f

echo Demetrius || [[ 6 -eq 7 ]] || echo Helena && echo Hermia || [[ 7 -gt 4 ]]

# true is true
# 1
# 45
# 7
# true
# false
# does math.sh exist?
# true
# f
# t
# Demetrius
# Hermia