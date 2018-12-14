Assignment:

Task 2:
1) How would you count the number of processes running as the user root? (2 marks)
	#ps displays info related to current running processes. -U switch used to specify user, in this case root. Use awk to print columns relevant to root and no. of processes.
	ps -eo user=|sort|uniq -c | grep 'root' | awk '{print $2" user is currently running "$1 " processes."}'
	
2) How would you display all environment variables that contain the user's username? This command should be usable by any user. (2 marks)
	#printenv displays all environment variables. grep - prints files matching a defined pattern, in this case the value of $USER. $USER - global variable, holds the value of the current logged in user.
	 printenv | grep "$USER"

3) How would you display all the lines with commands contained in square braces that are listed in the output of ps -ef? (2 marks)
 	#egrep - same as egrep, but allows usage or regex. -o - only matching, strictly only print matched pattern. '\[[^]]*]' - grep for pattern [], \ used to escape [, * used to pattern match [] regardless of content in between. You can use either of the below commands, run both and decide which you think is better. 
 	ps -ef | egrep -o '\[[^]]*]'
 or
 	ps -ef | egrep '\[[^]]*]'

4) How would you display all words in /usr/share/dict/words that contain all the vowels [a,i,o,u,e]? 
	 #same egrep usage as before, but here we use -v switch to show the inverse of the output.
	 egrep -v '^([^a]*|[^e]*|[^i]*|[^o]*|[^u]*)$' /usr/share/dict/words

5) How would you display the usernames and their associated home directories from /etc/passwd? (2 marks)
	#Declare filed seperator as ':', and print column 1 (username), and column 6 (user's respective home dir), < direct awk to read from /etcpasswd.
	awk -F':' '{print "User:"$1,"| ""Home Directory:"$6}' < /etc/passwd

6) How would you list all files in /etc that all users (owner, group and other) can read, using grep? (2 marks)
	#ls -lh - display all files along with permissions. grep '^-' pattern must begin with -, ie has to be file. grep '.r..r..r..' - where all users have read permissions.
	 ls -lh /etc | grep -E '^-r..r..r..' | awk '{print "Permissions:"$1, "| Filename: " $9}'

7) How would you print the modification date of the oldest file in /etc? (2 marks)
	#ls list all files, -l switch, use long list format for extra detail, -R switch, recursively, -t switch, sort by modification time, newest first. head - output first part of files. awk '{print $x}' - print specified columns for cleaner output.
	ls -lRt /etc | head -3 | awk '{print $6,$7,$8,$9}'

8) How would you count the number of different years in the modification dates of all files in /etc? Use ls -l to get the list of files and modification dates and don't worry about recently modified files which
don't have an associated year displayed. (2 marks)
	#ls -lRt - same as above. awk $8 - only show me the column containing years. egrep '^2' pattern HAS TO begin with a 2, '..' pattern can have any number in between. '.$' pattern has to end in a number. sort - sort lines of text. uniq -c - omit repeated lines, prefix lined by number of occurences. 
 	ls -lRt /etc | awk '{print $8}' | egrep '^2...$' | sort | uniq -c

9) How would you run the fortune command so that all the vowels in its output are displayed in uppercase? (2 marks)
	#fortune - prints random epigram. sed - used to replace source text/characters with destination characters. -y switch, used for transliterate a range of characters, in this case, replace each occurence of lowercase aeiou, with an uppercase AEIOU.
	fortune | sed 'y/aeiou/AEIOU/'

10) How would you count the number of files in /usr/share/games/fortunes/ that contain the string 'mark'. Note that the the file contents must contain the string, not the file's name ? (2 marks)
	 #-o switch, strictly only print matched pattern, in this case 'mark'. /usr/share/games/fortunes/* - User * to pattern match recursively through several directories. -i switch, case insensitive, eg pattern match evey possible variation of 'mark'. (mark, Mark, MARK, MArk, MARk, etc.)
 	grep -o 'mark' /usr/share/games/fortunes/* | wc -l
 or
 	grep -i -o 'mark' /usr/share/games/fortunes/* | wc -l