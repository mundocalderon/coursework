function plier {
  local sum=1
  for element in $@
  do
    sum=$(($sum * $element))
  done

  echo $sum
}


function isiteven {
  num=$(($1 % 2))
  if [[ $num -eq 0 ]]
  then 
    echo "1"
  elif [[ $num -ne 0 ]]
  then
    echo "0"
  else
    echo "doesn't work, num is : $num, and argument:$1"
  fi
}

function nevens {
  local sum=0
  for element in $@
  do
    temp=$(isiteven element)
    sum=$(($sum + $temp))
  done
  echo $sum
}

function howodd {
  evens=$(nevens $@)
  odds=$(($# - $evens))
  percentage=$(echo "scale=1;($odds / $#)*100" | bc -l)
  echo $percentage%
}

function fib {
 itor=$1
 f1=0
 f2=1
 while [[ $itor -ge 1 ]]
  do
   echo -n $f1
   fn=$(($f1 + $f2))
   f1=$f2
   f2=$fn
   
   itor=$(($itor - 1))
  done
 
}