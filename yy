#!/usr/bin/env zsh

## Description: Function
## Class: Autosource
## Licence: GLL / GLS
## Scriptor: ZSH
## Type: Shell

export yt_dir="$HOME/Music/yt"

make-yt-menu-new() {

	new_dir_name=$(kdialog --inputbox 'New Directory Name')
	sudo mkdir $HOME/Music/yt/$new_dir_name
	sudo chmod -R a+w,a+x $HOME/Music/yt/$new_dir_name
	sudo chown -R me:me $HOME/Music/yt/$new_dir_name

	if [ -d "$HOME/Music/yt/$new_dir_name" ]; then
		echo "New directory successfully created and is ready for use"
	fi

	$(kdialog \
	--yesno 'Download to this dir?' \
	--yes-label 'use' \
	--no-label 'do not use' \
	--title 'Mark new dir as IN-USE?' \
	)

	if [[ $? -eq 0 ]]; then
		export yt_dir_chosen="$yt_dir/$new_dir_name"
	else
		export yt_dir_chosen="no"
	fi

}

yt-menu() {
	HEIGHT=15
	WIDTH=40
	CHOICE_HEIGHT=4
	BACKTITLE="Get-Youtube Selection Menu"
	TITLE="Directory Selection"
	MENU="Choose the Directory to Download Batchfile to:"

	OPTIONS=(1 "Dubstep Dir"
				2 "For Mixing Dir"
				3 "Hip-Hop Dir"
				4 "Mixes"
				5 "Create New Directory"
	)

	CHOICE=$(kdialog --title "$TITLE" \
					 --menu "$MENU" \
					 "${OPTIONS[@]}" \

	)


	case $CHOICE in
		1)
			echo "Dupstep dir chosen"; export yt_dir_chosen=$HOME/Music/yt/dubstep; cd "$yt_dir_chosen";;
		2)
			echo "For mixing music dir chosen"; export yt_dir_chosen=$HOME/Music/yt/editing; cd "$yt_dir_chosen";;
		3)
			echo "Hip-hop dir chosen"; export yt_dir_chosen=$HOME/Music/yt/rap; cd "$yt_dir_chosen";;
		4)
			echo "Mixes dir chosen"; export yt_dir_chosen=$HOME/Music/yt/mixes; cd "$yt_dir_chosen";;
		5)
			make-yt-menu-new;;
	esac

	echo "The selected directory $yt_dir_chosen is where your next Youtube downlaod batchfile results will be saved to"

	if [[ $CHOICE = 1 ]]; then
		export yt_dir_chosen="$HOME/Music/yt/dubstep"
		cd "$yt_dir_chosen"
	fi
	if [[ $CHOICE = 2 ]]; then
		export yt_dir_chosen="$HOME/Music/yt/editing"
		cd "$yt_dir_chosen"
	fi
	if [[ $CHOICE = 3 ]]; then
		export yt_dir_chosen="$HOME/Music/yt/rap"
		cd "$yt_dir_chosen"
	fi
	if [[ $CHOICE = 4 ]]; then
		export yt_dir_chosen="$HOME/Music/yt/mixes"
		cd "$yt_dir_chosen"
	fi

	cd "$yt_dir_chosen"

}

function gettube() {
	source /main/source-docs/all
	setopt extendedglob
   #setopt emulate -L zsh

	spinner --style 'line' start 'Gathering information'
	sleep 3
	spinner stop

	HEIGHT=15
	WIDTH=40
	CHOICE_HEIGHT=4
	BACKTITLE="Get-Youtube Selection Menu"
	TITLE="Directory Selection"
	MENU="Choose the Directory to Download Batchfile to:"

	OPTIONS=(1 "Dubstep Dir"
				2 "For Mixing Dir"
				3 "Hip-Hop Dir"
				4 "Mixes"
				5 "Create New Directory"
	)

	CHOICE=$(kdialog --title "$TITLE" \
						  --menu "$MENU" \
						  "${OPTIONS[@]}" \

	)

	if [[ $CHOICE = 1 ]]; then
		export dir_chosen="$HOME/Music/yt/dubstep"
		cd "$dir_chosen"
	fi
	if [[ $CHOICE = 2 ]]; then
		export dir_chosen="$HOME/Music/yt/editing"
		cd "$dir_chosen"
	fi
	if [[ $CHOICE = 3 ]]; then
		export dir_chosen="$HOME/Music/yt/rap"
		cd "$dir_chosen"
	fi
	if [[ $CHOICE = 4 ]]; then
		export dir_chosen="$HOME/Music/yt/mixes"
		cd "$dir_chosen"
	fi

	cd "$dir_chosen"

	yt_batchfile="$HOME/yt/batchfile"
	sudo chown me:me "$yt_batchfile"
	sudo chmod a+w "$yt_batchfile"

	if [ ! -d "$dir_chosen" ]; then
		sudo mkdir -p "$dir_chosen"
		sudo chown -R me:me "$Dir_chosen"
		sudo chmod -R a+w,a+x "$dir_chosen"

		if [ -d "$dir_chosen" ]; then
			sudo chown -R me:me "$dir_chosen"
			sudo chmod -R a+x,a+w "$dir_chosen"

		fi
	fi

	export yt_test_dir="$HOME/Music/yt/test"
	export ytrap="$HOME/Music/yt/rap"
	if [ ! -d "$ytrap" ]; then
		sudo mkdir -p "$ytrap"
	fi

	cd $dir_chosen || echo "fuck you"

	sudo touch $HOME/yt/batch.log
	sudo chown me:me $HOME/yt/batch.log
	sudo chmod a+x,a+x $HOME/yt/batch.log

	sudo yt-dlp --extract-audio --force-ipv4 --no-playlist --skip-unavailable-fragments --trim-filenames 12 --no-cache-dir --audio-format mp3 --audio-quality 0 --batch-file "$yt_batchfile" >>$HOME/yt/batch.log 2>&1

	comment-batchfile

}

