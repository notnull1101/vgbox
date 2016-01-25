#!/bin/bash 
# List boxex 
function listboxes(){
	boxes=$(vagrant box list | tr -s '\n' "|")

	IFS="|" read -a boxlist <<< "$boxes"

	for (( i=0; i < ${#boxlist[@]}; i++ )); do 
		echo "*** " | tr -d '\n'
		echo "${boxlist[$i]}"
	done 

}

# Check
if [ -z $1 ] || [ -z $2 ] || [ -z $3 ];then 
	echo "*** Usage: $(basename $0) [box_name] [ram] [project_name]"
	exit
fi

# Check
if [[ ! $1 =~ ^[a-zA-z]+[/] ]];then
	echo "*** Invalid box name [$1] "
	echo "*** Available boxes"
	listboxes
	exit
fi

# Check 
if [[ ! $2 =~ ^[0-9]+$  ]];then
	echo "*** Invalid ram value [$2]"
	exit
elif [ $2 -lt 100 ]; then 
       	echo "*** Invalid RAM [${2}MB], please use 100MB or greater"	
	exit
fi

# Check 
if [[ $3 =~ ^[a-zA-z]+[/] ]];then
	echo "*** Invalid project name [$3] "
	exit
fi 

# Check
if [ -d $3 ];then 
	echo "*** Project [$3] already exist"
	exit
fi

# Vagrant Project Directory
APPDIR='/opt/vgbox/'
# Base Config File 
BASECONFIG="${APPDIR}Vagrantfile"
# README 
README="${APPDIR}README"
# Project PATH
PROJECTPATH="$(pwd)/${3}" 
# Project Name
PROJECTNAME=$(basename $PROJECTPATH)
# RAM 
RAM=$2
# BOXNAME	
BOXNAME=${1/\//\\/}

# Create Directory 
echo "-- Creating project directory [${PROJECTNAME}]"
mkdir "$PROJECTPATH"	

# Init Vagrant 
echo "-- Copying base config file"
sed "s/BOXNAME/$BOXNAME/g;s/VMNAME/${PROJECTNAME}_vagrant/g;s/RAM/$RAM/g" "${BASECONFIG}"  > "${PROJECTPATH}/Vagrantfile" 

# Change Directory To Project Path 
echo "-- Changing directory to project [${PROJECTNAME}]"
cd $PROJECTPATH

# Start VM 
echo "-- *Starting VM [${PROJECTNAME}]"
vagrant up 

if [ $? == 0 ];then 
	# Copy README File
	echo "-- Copying README "
	cp "${README}"  "${PROJECTPATH}/README" 

	# Create SSH Config File
	echo "-- Creating ssh config"
	vagrant ssh-config > .vagrant/machines/default/virtualbox/ssh-config

	# Connect To VM 
	echo "-- Connecting to VM [${PROJECTNAME}]"
	ssh -F .vagrant/machines/default/virtualbox/ssh-config default

else 
	# There Was An Error Creating The VM
	echo "*** There was an error creating vm [${PROJECTNAME}] please check"
	echo "*** Your config file [${BASECONFIG}]"
fi


