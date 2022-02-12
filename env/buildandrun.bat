@echo off
setlocal
set ext=%~x1

if not "%ext%" == ".asm" (
  echo Cannot build and run "%ext%" files.
  exit /b
)

"%~dp0\nasm" -fbin %1 -o%~n1.com

if errorlevel 1 (
  echo error
) else (
  for %%I in ("%~n1.com") do (
    echo %%~zI bytes
  )
  "%~dp0\dosbox.exe" %~n1.com
)
