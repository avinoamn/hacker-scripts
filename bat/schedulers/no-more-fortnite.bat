set start-time=12:00
set end-time=19:45
set modifier=1

set script-path="..\scripts\no-more-fortnite.bat"

schtasks /create /sc MINUTE /tn "no-more-fortnite" /tr %script-path% /st %start-time% /mo %modifier% /et %end-time%