#! /user/bin/
# CREATED BY: KAM
# Date created: 5/10/2021
# Version 1

# this script is desingned to gather system statistics.
AUTHOR="kam"
VERSION="1"
RELEASED="5/10/2021"
FILE=~/ace/systemStats.log

# Display help message

USAGE(){ 
	echo -e $1
	echo -e "\nUssage: systemStats [-t temperature] [-i ipv4 address] [-c cpu usage]"
	echo -e "\t\t [-v version]"
 	echo -e "\t\t more i8nformation see man systemStats"
}

# check for arguments (error checking)
if [ $# -lt 1 ];then
	USAGES"Not enough arguments"
	exit 1
elif [ $# -gt 3 ];then
 	USAGE" too many arguments supplies"
	exit 1
elif [[ ( $1 == '-h' ) || ( $1 == '--help' ) ]];then
	USAGE "help!"
	exit 1
fi

# frequently a scripts are written so that arguments can be passed in any order using 'flag'
# with the flags method , some of the arguments can be  made mandatory or optional
# a:b (a is mandator, b is  optional ) abc is all optional 
while getopts ctiv OPTION
do 
case ${OPTION}
in
i)  IP=$(ifconfig wlan0 | grep -w inet | awk '{print$2'})
	echo ${IP};;
c) USAGE=$(grep -w 'cpu' /proc/stat | awk '{usage=($2+$3+$4+$6+$7+$8)*100/($2+$3+$4+$5+$6+$7+$8)}
						{free=($5)*100/($2+$3+$4+$5+$6+$7+$8)} 
				                END{printf" Used cpu: %.2f%%",usage} 
					           {printf" Free cpu: %.2f%%",free}')
	echo ${USAGE};;
t) TEMP=$(cat /sys/class/thermal/thermal_zone0/temp)
	echo ${TEMP} "need to divide by thousend...";;
v)	echo -e "systemStats:\n\t version: ${VERSION} Released: ${RELEASED} Author: ${AUTHOR}";;
esac
done 

	NOW=$(date +%Y-%m-%dT%H:%M:%SZ)
	echo	-e " ${NOW}\tIP: ${IP} Temperature: ${TEMP} CPU: ${USAGE}" >> ${FILE}  

# end of the script

