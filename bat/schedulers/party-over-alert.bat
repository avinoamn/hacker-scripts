set alert-time=19:45

set script-path="..\scripts\party-over-alert.bat"

schtasks /create /sc DAILY /tn "party-over-alert" /tr %script-path% /st %alert-time%