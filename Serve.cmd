@echo off
cd /d "%~dp0"
echo Secret Squares: http://127.0.0.1:8003/
echo Close this window to stop the local server.
start "" "http://127.0.0.1:8003/"
python -m http.server 8003 --bind 127.0.0.1
pause
