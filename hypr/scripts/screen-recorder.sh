#!/usr/bin/env sh

# If an instance of wf-recorder is running under this user kill it with SIGINT and exit
pkill --euid "$USER" --signal SIGINT wf-recorder && exit

# Define paths
DefaultSaveDir=$HOME'/Videos/Recordings'
TmpPathPrefix='/tmp/mp4-record'
TmpRecordPath=$TmpPathPrefix'-cap.mp4'
TmpPalettePath=$TmpPathPrefix'-palette.png'

# Trap for cleanup on exit
OnExit() {
	[[ -f $TmpRecordPath ]] && rm -f "$TmpRecordPath"
	[[ -f $TmpPalettePath ]] && rm -f "$TmpPalettePath"
}
trap OnExit EXIT

# Set umask so tmp files are only acessible to the user
umask 177

# Get selection and honor escape key
Coords=$(slurp) || exit

# Capture video using slup for screen area
# timeout and exit after 10 minutes as user has almost certainly forgotten it's running
timeout 600 wf-recorder -g "$Coords" -a -f "$TmpRecordPath" || exit

# Get the filename from the user and honor cancel
SavePath=$( zenity \
	--file-selection \
	--save \
	--confirm-overwrite \
	--file-filter=*.mp4 \
	--filename="$DefaultSaveDir"'/.mp4' \
) || exit

# Copy the file from the temporary path to the save path
cp $TmpRecordPath $SavePath

# copy the file location to your clipboard
wl-copy $SavePath

# Return umask to default
umask 022
