#!/bin/bash

#Move certain files from one directory to the next


inputFunc(){

	echo "Input interval time (in minutes) to move files" 
	read inputTime
	checkNum $inputTime		#check if input is an integer.

	echo "Please input how many files you would like to transfer at a time"
	read inputFileCount
	checkNum $inputFileCount	#check if it's an integer.

	echo "Choose Folder to move files from"
	read startFolder
	checkDir $startFolder		#check if input is a valid directory.

	echo "Choose Folder to send files to"
	read endFolde
	checkDir $endFolder		#check if input is a valid directory.
	


	while ! [ -z "$(ls -A $startFolder)" ];		#directory not empty
	do
		((count = $inputFileCount))		#get files to be moved at a time
		for file in "$startFolder"/*.csv;	#get files in startFolder
		do
			mv "$file" "$endFolder"
			echo "moving file $file"
			((count --))
			[[ ${count} -eq 0 ]] && break;	#break when files to be moved at a time has been reached
		done
		echo "sleep for $inputTime minutes"	
		sleep $(($inputTime * 60))		#wait for minutes
	done
	
	echo "Finished processing all Files"
}

checkNum(){
	
	if [ "$1" -eq "$1" ] ; then
		printf "\n$1 is the number you entered \n"
	else
		printf Q"\n$1 not a number try again \n"
		inputFunc
	fi
}

checkDir(){
 
	if [[ -d $1 ]]; then
		printf "\n$1 is a directory with $(ls -l $1 | wc -l ) files\n"
	else
		printf "\n$1 not a directory try again\n"
		inputFunc
	fi
}


inputFunc

printf "\n************end of program********************\n
****************************************"


