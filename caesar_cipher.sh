#!/bin/bash

# Created by: Diego G. Ureno
# California State University, East Bay
# July 7, 2023

# Main Menu Function
main_menu() {
	clear
	echo "-----------------------------"
	echo "| C A E S A R   C I P H E R |"
	echo "-----------------------------"
	echo "1 - Encrypt Message"
	echo "2 - Decrypt Message"
	echo "3 - Read File Contents"
	echo "4 - Close Program"
}

# User Input Function
user_input() {
	local input
	read -p "Select an Option [1 - 4]: > " input
	case $input in
		1) encrypt_message;;
		2) decrypt_message;;
		3) read_file_contents;;
		4) exit 0;;
		*) echo "Error: Invalid Input";;
	esac
}

# A Pause Function - Prompt User Before Returning to Menu
return_to_menu() {
	read -p "Return to Main Menu? [Y/n]: > " choice
	if [[ ( $choice == "N" || $choice == "n" ) ]];
	then
		# Exit Program
		exit 0
	fi
}

# Encrypt Message Function
# Prompts choice of encryption type
encrypt_message() {
	echo "------------------------------"
	echo "Select Encryption Type [1-2]: "
	echo "1 - CC (Caesar Cipher)"
	echo "2 - ROT13"
	read -p "> " encryption_type

	# Select Caesar Cipher
	if [ $encryption_type -eq 1 ];
	then
		# Run Caesar Cipher Function
		caesar_cipher

	# Select ROT13
	elif [ $encryption_type -eq 2 ];
	then
		# Run ROT13 Function
		rot13

	# Invalid Input
	else
		echo "Error: Invalid Input!"
	fi

	# Prompt User to Return to Menu
	return_to_menu

}

# Decrypt Message Function
# Decrypts Text File (CC or ROT13)
decrypt_message() {
	echo "----------------------"
	echo "Select Decryption Type"
	echo "1 - CC"
	echo "2 - ROT13"
	read -p "> " input_type

	# Select Decrypt Caesar Cipher
	if [ $input_type -eq 1 ];
	then
		# Input Text File
		read -p "Enter Filename: " filename

		# Set Secret Message to Text File Contents
		unsecret=$(cat "$filename")

		# Asks User for No. of Shifts to Make Key
		read -p "Enter Number of Shifts: " shifts

		# Decrypt Message - CC
		for (( counter=$shifts; counter<26; counter++ ))
		do
			# 1 Loop = 1 Letter Shift
			unsecret=$(echo "$unsecret" | tr "[A-Za-z]" "[B-ZA-b-za]")
		done

		# Output Decrypted Message
		echo " "
		echo "Outputting Decrypted Message: "
		echo "------------------------------"
		echo "$unsecret"

	# Select Decrypt ROT13
	elif [ $input_type -eq 2 ];
	then
		# Input Text File
		read -p "Enter Filename: " filename

		# Set Secret Message to Text File Contents
		unsecret=$(cat "$filename")

		# Decrypt Message - ROT13
		for (( counter=0; counter<13; counter++ ))
		do
			unsecret=$(echo "$unsecret" | tr "[A-Za-z]" "[B-ZA-b-za]")
		done

		# Output Decrypted Message
		echo " "
		echo "Outputted Decrypted Message"
		echo "---------------------------"
		echo "$unsecret"

	# Case - Invalid Input
	else
		echo "Invalid Input"
	fi

	# Save Decryption to File
	read -p "Save to a file? [Y/n]: > " input

	# Case - Save Output to File
	if [[ ( $input == "Y" || $input == "y" ) ]]
	then
		# Prompt User for Output File
		read -p "Enter Filename: " filename

		# Add Decrypted Message to File Contents
		echo "$unsecret" >> $filename
	else
		echo " "
		echo "Content Not Saved!"
	fi

	return_to_menu
}

# Read File Contents Function
# Outputs File Contents
read_file_contents() {

	# Prompt User for File
	read -p "Enter Filename to Read: " filename
	echo "----------------------------"

	# For Loop to Read Words in File
	for word in `cat $filename`
	do
		# Output Words
		echo $word
	done

	echo "----------------------------"

	return_to_menu
}

# Caesar Cipher Function
# Uses tr to shift characters
caesar_cipher() {

	# Prompt User for Input Type
	echo "Select Input Type: "
	echo "------------------------"
	echo "1 - Read From File"
	echo "2 - User Input"
	read -p "> " input_type

	# Option 1 - Read From File
	if [ $input_type -eq 1 ];
	then
		# Prompt User for File
		read -p "Enter Filename: " filename

		# Prompt Number of Shifts for Plaintext
		read -p "Enter Number of Shifts: " shifts

		# Set Message to File Contents
		secret=$(cat "$filename")

		# Shift File Characters 
		for (( counter=0; counter<$shifts; counter++ ))
		do
			# 1 Loop = 1 Shift
			secret=$(echo "$secret" | tr "[A-Za-z]" "[B-ZA-b-za]")
		done

		# Output Newly Encrypted Text
		echo " "
		echo "Encrypting Message..."
		echo "---------------------"
		echo "$secret"

	# Option 2 - User Input
	elif [ $input_type -eq 2 ];
	then
		# Input Message
		read -p "Enter a message: " message

		# Input Number of Shifts
		read -p "Enter Number of Shifts: " shifts

		# Set Variable to Message Contents for Loop
		secret="$message"

		# Shift Message Characters
		for (( counter=0; counter<$shifts; counter++ ))
		do
			# 1 Loop = 1 Shift
			secret=$(echo "$secret" | tr "[A-Za-z]" "[B-ZA-b-za]")
		done

		# Display Newly Encrypted Message
		echo " "
		echo "Encrypting Message..."
		echo "---------------------"
		echo "$secret"

	# Case - Invalid Input
	else
		echo "Invalid Input"
	fi

	# Save Output/Update to File

	read -p "Save to a file? [Y/n] " input

	# Select Save Output
	if [[ ( $input == "Y" || $input == "y" ) ]]
	then
		# Prompt User for File
		read -p "Enter filename: " filename

		# Update File Contents with Newly Encrypted Message
		echo "$secret" >> $filename
		echo "---- Contents Saved ----"

	# Else Close Function
	else
		echo "Content Not Saved!"
	fi

}

# ROT13 Function
# Caesar Cipher encryption with shift=13
rot13() {
	echo "Select Input Type [1-2] "
	echo "------------------------"
	echo "1 - Read From File"
	echo "2 - User Input"
	read -p "> " input_type

	# Option 1 - Read From File
	if [ $input_type -eq 1 ];
	then
		# Prompt User for File
		read -p "Enter filename: " filename

		# Set Message to File Contents
		secret=$(cat "$filename")

		# Encrypt File Contents
		for (( counter=0; counter<13; counter++ ))
		do
			# Shift 13
			secret=$(echo "$secret" | tr "[A-Za-z]" "[B-ZA-b-za]")
		done

		# Display ROT13 Message
		echo " "
		echo "Encrypting Message..."
		echo "---------------------"
		echo "$secret"

	# Option 2 - User Input
	elif [ $input_type -eq 2 ];
	then
		# Prompt Message Input
		read -p "Enter a message: " message

		# Set Variable to Input for Loop
		secret="$message"

		# Encrypt File Contents
		for (( counter=0; counter<13; counter++ ))
		do
			# Shift 13
			secret=$(echo "$secret" | tr "[A-Za-z]" "[B-ZA-b-za]")
		done

		# Display ROT13 Message
		echo " "
		echo "Encrypting Message..."
		echo "---------------------"
		echo "$secret"

	# Case - Invalid Input
	else
		echo "Invalid Input"
	fi

	# Save Output/Update to File

	read -p "Save to a file? [Y/n]: > " input

	# Select Save Output
	if [[ ( $input == "Y" || $input == "y" ) ]]
	then
		# Input Filename to Save Output
		read -p "Enter filename: " filename

		# Fill File Contents with Output
		echo "$secret" >> $filename
		echo "---- Contents Saved ----"

	# Select to Not Save Output
	else
		echo "Content Not Saved!"
	fi
}

# Looping Menu

while true
do
	# Return to Main Menu
 	 main_menu

	# Prompt For User Input
 	 user_input
done
