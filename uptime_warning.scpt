set uptimeResult to do shell script "uptime"

if uptimeResult contains "days" then
	set {TID, text item delimiters} to {text item delimiters, "up "}
	set uptimeResult to text item 2 of uptimeResult
	set text item delimiters to ","
	set uptimeResult to text item 1 of uptimeResult
	set text item delimiters to TID
	set input to 3600
	--set shutdown_time to (current date) + (input)
	set theArray to every text item of the uptimeResult
	--say "You need to restart"
	
	display dialog "Your system has been up for : " & theArray with icon caution buttons {"Restart Now", "Restart After 1 Hour"} default button "Restart Now"
	
	if button returned of result = "Restart Now" then
		tell application "System Events"
			restart
		end tell
	else
		if button returned of result = "Restart After 1 Hour" then
			set shutdown_time to (current date) + (input * minutes)
			with timeout of 4000 seconds
				delay input
			end timeout
			tell application "System Events"
				restart
			end tell
		end if
	end if
end if


--on idle
--if (shutdown_time < (current date)) then
--do shell script "osascript <<'EOF' &>/dev/null &
--delay 5
--ignoring application responses
--tell application \"System Events\"
--restart
--end tell
--end ignoring
--EOF"
--quit
--end if
--return 1
--end idle
