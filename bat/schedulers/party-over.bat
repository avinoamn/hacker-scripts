set lock-time=20:00

set script-path="..\scripts\party-over.bat"

schtasks /create /sc DAILY /tn "party-over" /tr %script-path% /st %lock-time%