protm1=(ou bu wu be le oe we be)
protm2=(du iu cu ce de de de de)
protm3=(ou bu wu be le oe we be)
protm4=(du iu cu ce de de de de)

#protm1=(ee)
#protm2=(ee)
#protm3=(ee)
#protm4=(ee)

set -x
function checkcc()
{       
        echo $1 #round
        echo $2 #machine
	echo $3 #return string
        if [ $2 -ge 11 -a $2 -lt 14 ]; then
		eval "$3='${protm1[$1]}'"
		return
        fi
        
        if [ $2 -ge 14 -a $2 -lt 17 ]; then
                eval "$3='${protm2[$1]}'"
		return
        fi
        
        if [ $2 -ge 17 -a $2 -lt 20 ]; then
                eval "$3='${protm3[$1]}'"
        	return
	fi
        
        if [ $2 -ge 20 -a $2 -lt 23 ]; then
		eval "$3='${protm4[$1]}'"        
		return
	fi
}

cc=''
checkcc 0 22 cc
echo $cc
