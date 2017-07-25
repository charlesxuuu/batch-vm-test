t=2

if [ $(($t%2)) -eq 0 ]
then
	echo 'a'
else 
	echo 'b'
fi
