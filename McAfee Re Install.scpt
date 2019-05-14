on findAndReplaceInText(theText, theSearchString, theReplacementString)
	set AppleScript's text item delimiters to theSearchString
	set theTextItems to every text item of theText
	set AppleScript's text item delimiters to theReplacementString
	set theText to theTextItems as string
	set AppleScript's text item delimiters to ""
	return theText
end findAndReplaceInText

on executeCommand(theCommand)
	tell application "Terminal"
		set myTab to do script theCommand
		repeat until (myTab's history contains theCommand)
			delay 1
		end repeat
		repeat while (myTab's busy)
			delay 1
		end repeat
		close (first window whose selected tab is myTab) saving no
		--display dialog "Finished : " & theCommand
	end tell
end executeCommand


local current_path
local theCommand
local cmdList
local myTab
local result_1
set current_path to POSIX path of (path to me as text)
set current_path to findAndReplaceInText(current_path, "/McAfee Re Install.app", "")
local password
display dialog "In order to execute Admin tasks, we need your password 
Enter your password : " default answer "" with hidden answer
set password to text returned of result

set cmdList to {"MAC/McAfeeCleanUpTool", "MA5.6/install.sh -i", "MNE4.1.5/mne-install.sh"}
repeat with a from 1 to length of cmdList
	set theCommand to item a of cmdList
	executeCommand("echo " & password & " | sudo -S " & current_path & theCommand)
end repeat

set cmdList to {"e", "p", "c", "f"}
repeat with a from 1 to length of cmdList
	set theCommand to item a of cmdList
	executeCommand("echo " & password & " | sudo -S /Library/McAfee/cma/bin/cmdagent -" & theCommand)
end repeat

quit application "Terminal"

display dialog "The Setup has been done !"
