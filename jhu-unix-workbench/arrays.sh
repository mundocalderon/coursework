test_array=(one two three four)
test_array2=(five six seven)
echo ${test_array[$1]}

cat_count=$((${#test_array[*]} + ${#test_array2[*]}))
echo $cat_count

lab=(jeff roger brian)
echo ${#lab[*]}
lab[3]=sean
echo ${#lab[*]}
lab=("${lab[*]}" "${lab[*]}")
echo ${#lab[*]}
echo ${lab[0]}
echo ${lab[1]}