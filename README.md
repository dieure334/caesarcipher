# caesarcipher
A looping-menu shell script that can read files and perform the Caesar Cipher as well as its special case, ROT13. This is done by using the translate command (__*tr*__), which allows for the shifting of characters. Input must be a text file or some other source of text. This script was created as part of an assignment for a Linux Programming class.

-------------------------------------------------------------------------------------------------------------------------------------------------------

__EXECUTION__:

Use the following command to run the source code: __./caesar_cipher__

-------------------------------------------------------------------------------------------------------------------------------------------------------

__HOW TO USE__:

Input the options 1-4 to perform a certain task:

1. __Encrypt File__: Script requests source file to be converted to ciphertext. After conversion, script prompts user on whether they would like to save the newly created ciphertext. New files can be created if user provides a new filename and will appear in the working directory.

2. __Decrypt File__: Script requests source file to be converted back to plaintext. User may save decrypted text into a new file to the working directory.

3. __Read File__: Scripts requests file to read content from. This is a simply a form of the *cat* command, which reads file contents.

4. __Exit__: Exits the shell script. Any changes saved will appear within the working directory.
