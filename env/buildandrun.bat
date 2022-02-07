@echo off
setlocal

"%~dp0\nasm" -fbin %1.asm -o%1.com

if errorlevel 1 (
  echo error
) else (
  for %%I in ("%1.com") do (
    echo %%~zI bytes
  )
  "%~dp0\dosbox.exe" %1.com
)
