@echo off
echo Starting local web server...
echo.
echo Open in browser: http://localhost:8000
echo Press Ctrl+C to stop
echo.
python -m http.server 8000
