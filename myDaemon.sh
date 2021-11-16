#! /usr/bin/env bash


#created by:Kamyar
# Date created:2021-11-02

DAEMONNAME="MY-DAEMON"

#$$ is process ID (PID) of the script itself
MYPID=$$
#get the directory path for the script
PIDDIR="$(dirname "${BASH_SOURCE[0]})"
PIDFILE="$ {PIDDIR/${DAEMONE}.pid"

LOGDIR="${dirname "${BASH_SOURCE[0]}")"

LOGFILE="$(LOGDIR}/${DAEMONNAME}.log"
LOGMAXSIZE=1024

RUNINTERVAL=60 #in sceonds
documents(){
	echo "running commands."
	log'***'4(date +"%Y-%m-%dT%H:%M:%SZ")": an important message or lg details..."
}

##################################################################################################
#BEWLOW IS THE TEMPLATE FUCTIONALLY OF DAEMON
#################################################################################################
setupDaemon() {
#Make sure that directories work.
if[[ ! -d "${PIDDIR}" ]]; then
	mkdir "${PIDDIR}"
fi

 if[[ ! -d "${LOGDIR}" ]]; then
        mkdir "${LOGDIR}"
fi

 if[[ ! -d "${LOGFILE}" ]]; then
        touch "${LOGFILE}"
	else
SIZE=$(( $(stat --printf="%s" "s{LOGFILE}")/1024))

if[[ ${size} -gt ${LOGMAXSIZE} ]]; then
	mv ${LOGFILE} "LOGFILE}·$(date +%Y-%m%dT%H:M:%SZ).old"
	touch "{LOGFILE}"
        fi
      fi
}
startDaemon(){
	setupDaemon
	
	if ! checkDaemon; then
	echo 1>&2 "ERROR: ${DAEMONNAME} is already running."
	log '***'$(date +"%Y-%m-%dT%H:%M:%SZ")":$USER already runnig ${DAEMON} PID "$(cat ${PIDFILE})
	exit 1 
    fi 
	echo"starting ${DAEMONNAME} with PID: {MYPID}."
	echo "{MYPID}" > "${PIDEFILE}"
log '*** ' $(date +"%Y-%m-%dT%H:%M:%SZ")":user STARTING UP ${daemonname}PID: ${MYPID}."

loop
}
stopDaemon() {
#Stop the daemon
	if checkDaemon;then
	echo 1>&2 " Errors: ${DAEMONNAME} is not runnig."
	exit 1
   fi
	echo"* Stopping${DAEMONNAME}"

	if [[ ! -z $(cat "${{PIDEFILE}" ]]; then
	kill -9 $(cat "${PIDEFILE}" &> /dev/nul
log '*** '$(date +"%Y-%m-%dT%H:%M:%SZ")": ${DAEMONNAME} stopped. " 
	else
	echo 1>&2 "CAnnot find PID of running daemon"
	fi
}
statusDaemon() {
	if ! checkDaemon; then
	echo " * ${DAEMONNAME} isn't running"
	log '***'$(date +"%Y-%m-%dT%H:%M:%SZ")": ${DAEMONAME} $USER checked statuse - Running with PID: ${MYPID}"
	else	
	echo" * $(DAEMONNAME} isn't running."
	log '***'$(date +"%Y-%m-%dT%H:%M:%SZ")": ${DAEMONNAME} $USER checked statuse - Not Running."
	fi	
	exit 0
}
restartDaemon() {

	if checkDaemon; then
	echo " $ {DAEMONNAME} isn't running."
	log '***'$(date +"%Y-%m-%dT%H:%M:%SZ")": ${DAEMONNAME} $ USER restarted"
	exit 1
	fi
stopDaemon
startDaemon
}
check daemon() {
	if  [[ -z "{OLDPID}" ]]; then
 	return 0
	elif ps -ef | grep "${OLDPID}" | grep -v grep &> /dev/null ; then
	if [[ -f "${PIDFILE}" && $(cat "${PIDFILE)" -eq ${OLDPID} ]]; then
#demon is running
	return 1
	else
#DAemon isn't running .
	return 0
        fi
	elif ps -ef | grep "${DAEMONNAME}" | grep -v grep | grep -v "${MYPIDE}" |
		      grep -v "0:00.00" | grep bash &> /dev/null ; then
#Daemon is running but without the correct PID. REstart it.
log '***'$(date +"%Y-%m-%dT%H:%M:%SZ")": ${DAEMONNAME} running with invalid PID: restarting."
restartDaemon
	return 1
	else
#Daemon isn't running .
	return 0
	fi
	return 1
}

loop() {

	while true; do
	docommands
	sleep 60
       done
}
	log() {
#Generic log function.
	echo " $1" >> "${LOGFILE}"
}
#############################################################
#parse  the command.
############################################################
	if[[ -f "{PIDFILE}" ]]; then
	 OLDPID=$(cat "{PIDEFILE}")
	fi
	CheckDaemon
	case "$1" in
	start)
		startDaemon
	;;
	stop)
		stopDaemon
	;;
	status)
		statusDemon
	;;
	restart)
		restartDeamon
	;;
	*)
	echo 1>&2 " * Error: usage $0 { start | stop | restart | status }"
	exit 1
      esac
 #close program as intend 

	exit 0	
