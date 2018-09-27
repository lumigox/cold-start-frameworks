#!/bin/bash

usage() {
    cat <<EOM
.____                  .__                  .__        
|    |    __ __  _____ |__| ____   ____     |__| ____  
|    |   |  |  \/     \|  |/ ___\ /  _ \    |  |/  _ \ 
|    |___|  |  /  Y Y  \  / /_/  >  <_> )   |  (  <_> )
|_______ \____/|__|_|  /__\___  / \____/ /\ |__|\____/ 
        \/           \/  /_____/         \/            

    Usage:
    	$(basename $0) <folder name> <memory size>
    	<folder name> - A serverless framework folder to deploy to AWS.
    	<memory size> - Use this amount of memory for the function.

EOM
    exit 0
}

function ctrl_c() {
    echo -e "\nRemoving function"
    rm *.tmp
	sls remove > /dev/null
	exit 0
}

if [ $# -ne 2 ]; then
    usage
    exit 1
fi
echo ".____                  .__                  .__        ";
echo "|    |    __ __  _____ |__| ____   ____     |__| ____  ";
echo "|    |   |  |  \/     \|  |/ ___\ /  _ \    |  |/  _ \ ";
echo "|    |___|  |  /  Y Y  \  / /_/  >  <_> )   |  (  <_> )";
echo "|_______ \____/|__|_|  /__\___  / \____/ /\ |__|\____/ ";
echo "        \/           \/  /_____/         \/            ";

echo "Press [CTRL+C] to stop at any time"
echo
directory=$(echo $1|tr -d [=/=])
cd $directory
echo Preparing template
cp serverless_template.yml serverless.yml
sed -i -e "s/@MEMORY@/$2/g" serverless.yml
sed -i -e "s/@DATE@/$(date '+%s')/g" serverless.yml
echo Installing dependencies
npm install
counter=1
echo "Deploying serverless defined in $1 with $2 MB of memory."
function_name=$(sls deploy |grep "function" -A1|tail -1|awk -F ":" '{print $1}'| tr -d '[:space:]')
[ -z "$function_name" ] && echo "Deployment failed" && exit 1
echo "Deployed to $function_name"
# trap ctrl-c and call ctrl_c()
trap ctrl_c SIGINT
while true
do
	echo "Run #$counter"
	# Break into array, element 0 is executiontime and element 1 is exit code
	result=($({ /usr/bin/time -f %E sls invoke --function $function_name;echo "$?";} 2>&1|tail -2))
	# Clear time, remove trailing minutes
	full_time=${result[0]}
	cleared_time=$(echo $full_time|awk -F ":" '{print $NF}')
	echo "Took $cleared_time seconds with exit code of ${result[1]}"
	echo "$(date '+%FT%T'),$cleared_time,${result[1]}" >> ../"$directory_$2.csv"
	counter=$(( $counter + 1 ))
	# Avoid Code not changed causing function deployment to skip
	touch "$counter.tmp"
	sls deploy function -f $function_name
	rm "$counter.tmp" &>/dev/null
done