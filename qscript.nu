#!/usr/bin/env nu

# def ":q" [] {
# 	exit
# }

# :q

# create a backup of a given file
# if no file is given, a backup of all files in the current folder is created
# hidden files included
def backup [
	file?: string	# the file to backup
] {
	if ($file == null) {
		mkdir -s nubackup

		ls -a |
		where type == file | 
		par-each {
			|it| cp --verbose $it.name nubackup/ |
		}
	} else {
		mkdir -s nubackup

		cp --verbose $file nubackup/ 
	}
}
