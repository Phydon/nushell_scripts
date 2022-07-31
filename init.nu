# Gets the name of the running operating system
export def getos [] {
	sys | get host.name
}

export def ":q" [] {
	exit
}

# Gets all active aliases
export def "get aliases" [] {
	open $nu.config-path | 
	lines | 
	find alias | 
	find -v "#" | 
	split column "=" | 
	select column1 column2 | 
	rename Alias Command | 
	update Alias {
		|f| $f.Alias | 
		split row " " | 
		last
	} | 
	sort-by Alias
}

# Creates a backup of your nushell command history
export def "history backup" [] {
	mkdir ~/backup

	open $nu.history-path | 
	save ~/backup/history.txt
}

# Creates a backup of your nushell command history and removes all duplicates in the $nu.history-path
export def "history remove_duplicates" [] {
	history backup

	open $nu.history-path | 
	lines | 
	into df | 
	drop-duplicates | 
	into nu | 
	get "0" | 
	save $nu.history-path
}

# Get input by words as a table
# Returns the words stored in a table seperated into rows by default
export def words [
	--list (-l)		# Return a list of words seperated into rows
	--column (-c)	# Return the words stored in a table seperated into columns
] {
	let input = ($in | str trim)

	if ($input | empty?) {
		# Do nothing
	} else if $column {
		$input |
		split column -c " "
	} else if $list {
		$input |
		split row " "
	} else {
		$input |
		split row " " |
		wrap word
	}
}
