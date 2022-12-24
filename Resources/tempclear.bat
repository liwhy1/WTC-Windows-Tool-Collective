@ECHO off

WSReset.exe
taskkill /F /IM WinStore.App.exe

taskkill /F /IM explorer.exe
rmdir /S /Q C:\Users\%username%\AppData\Local\Temp\
rmdir /S /Q C:\Windows\Temp\
rmdir /S /Q C:\Windows\Prefetch\
rmdir /S /Q C:\Windows\SoftwareDistribution\

ipconfig /flushdns
ipconfig /release
ipconfig /renew
netsh install
netsh winsock reset

rmdir /S /Q C:\Users\%username%\AppData\Local\NVIDIA\DXCache\
rmdir /S /Q "C:\Users\%username%\AppData\Local\NVIDIA\GLCache\

cleanmgr.exe
explorer.exe

echo Cleaning completed!
echo Restart Recommended!
PAUSE