@echo off

:: CONSTS
set WINDOWS_HOSTS_PATH=C:\Windows\System32\drivers\etc\hosts
set GAME_TIME_COUNTER_PATH=..\data\game-time-counter
set LAST_PLAYED_PATH=..\data\last-played
set DEFAULT_HOSTS_PATH=..\data\default-hosts
set BLACKLIST_HOSTS_PATH=..\data\blacklist-hosts

set GAMES_LIST=fortnite minecraft naruto
set TASKS_LIST=steam epic minecraft

set /A MAX_GAME_TIME=180

:: Reset game-time-counter to 0 and hosts file to `default-hosts` if %now% is not the same date as %last-played% 
set last-played=<%LAST_PLAYED_PATH%
set now=%DATE%

if %now% NEQ %last-played% (
    echo 0 > %GAME_TIME_COUNTER_PATH%
    echo %now% > %LAST_PLAYED_PATH%
    copy %DEFAULT_HOSTS_PATH% %WINDOWS_HOSTS_PATH% /Y
    exit
)

:: taskkill %TASKS_LIST% and replace hosts with `blacklist-hosts` if %game-time-counter%>=%MAX_GAME_TIME%.
:: else, increment %game-time-counter% if any game from %GAMES_LIST% is being played.
set /A game-time-counter=<%GAME_TIME_COUNTER_PATH%

if %game-time-counter% GEQ %MAX_GAME_TIME% (    
    (for %%t in (%TASKS_LIST%) do (
        taskkill /fi "WINDOWTITLE eq %%t*"
        copy %BLACKLIST_HOSTS_PATH% %WINDOWS_HOSTS_PATH% /Y
    ))
) else (
    set /A games-being-played=0

    (for %%g in ('tasklist | findstr "%GAMES_LIST%"') do (
        set /A games-being-played=%games-being-played%+1
    ))

    if %games-being-played% GTR 0 (
        set /A game-time-counter=%game-time-counter%+1
        echo %game-time-counter% > %GAME_TIME_COUNTER_PATH%
    )
)