#!/bin/bash


echo "This script will access the gitURLS and update the regex then commit and push it."
echo "#Author: RAVI KURIL"

LIST=' https://github.com/ravikuril/php_mysql_connection.git
'
echo "******************************************************"
echo "URL LIST"
echo "******************************************************"
for var in $LIST
do
	echo $var
done

travrse_git_folder_structure()
{
	git status
}
#Post operation clean up
remove_clone_repository()
{
	rm -rf	 $1
	echo -e "\nRemoved cloned directory " $1
}

add_commit_push_new_files()
{
	#mkdir testDIR
	#touch test.txt
	git add .
	git commit -m "I am a robot and my work is to fix things"
	git push 
}
remove_files_and_directory_from_remote()
{
	#LIST of filenames, directory names to be removed
	list='test.txt
	testDIR'

	for i in $list
	do
		rm -rf $i
	done
	git add .
	git commit -m "removed files"
	git push
}


#this is called when one step back head of commit is required locally and remote
# Safe when few people already pulled latest commit which one want to remove
git_revert_and_push()
{
	git revert --no-commit HEAD~1^..HEAD   #goes back 2 commit heads 
	git push
}

#USE CAREFULLY : removes remote commit history
git_reset_hard()
{
	git reset --hard $1
	git push --force	
}
#oneline logs
generate_log_file()
{
	git log --oneline > log_file
}

adding_more_files_in_previous_commit()
{
	git add .
	git commit --amend --no-edit
}

editing_a_commit_locally_without_opening_a_vim()
{
	git commit --amend -m "new message"
}

for var in $LIST
do

	echo "******************************************************"
	echo "CLONING gitURL" $var
	echo "******************************************************"
	git clone $var

	#extracting git repository name for cd
	echo -e "\nGIT CLONE STATUS\n"
	i=${#var}
	end=0
	temp_string=
	while ((i-->-1))
		do
			char=$(expr substr "$var" $i 1)
			if [ "$char" = "." ]; then  
				end=1
				continue
			fi
			if [ "$char" = "/" ]; then
				i=-1
				break
			fi
			if [ $end = 1 ]; then 
				temp_string=$char$temp_string
				echo -ne \*
			fi
		done

	DIRECTORY_NAME=$temp_string

	#check if clone is successful
	if [ -d "$DIRECTORY_NAME" ]; then 
		
		cd $DIRECTORY_NAME

		#BOT JOB decsription add/commit/push-newfiles-function 
		#add_commit_push_new_files

		# #undo remote as well current commit
		# undo_remote_local_commits

		#remove file from remote repository 
		#remove_files_and_directory_from_remote

		# #git revert and push
		# git_revert_and_push 					# need to give target reference <commit_hash>

		#CAREFUL : removes remote commit history
		#commit_hash=1d350a128e05f86e08f31003ef84e863db49a2bc
		#git_reset_hard $commit_hash

		# #generate_git file
		# generate_log_file

		cd ..
		#remove_clone_repository $DIRECTORY_NAME
	else
		echo "!!!Error git clone failed, failed to get DIRECTORY_NAME= $DIRECTORY_NAME"
	fi
done


