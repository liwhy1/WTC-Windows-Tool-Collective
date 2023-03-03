#Port of Tempclear.bat
		Write-Output "Resetting Windows Store"
		WSReset.exe
		taskkill /F /IM WinStore.App.exe
		taskkill /F /IM explorer.exe

		Write-Output "Removing Temporary Files"
		Remove-Item -Path C:\Users\*\AppData\Local\Temp -Include *.* -Recurse -ErrorAction SilentlyContinue
		Remove-Item -Path C:\Windows\Temp\ -Include *.* -Recurse -ErrorAction SilentlyContinue
		Remove-Item -Path C:\Windows\Prefetch\ -Include *.* -Recurse -ErrorAction SilentlyContinue
		Remove-Item -Path C:\Windows\SoftwareDistribution\ -Include *.* -Recurse -ErrorAction SilentlyContinue
		Remove-Item -Path C:\Users\*\AppData\Local\NVIDIA\DXCache\ -Include *.* -Recurse -ErrorAction SilentlyContinue
		Remove-Item -Path C:\Users\*\AppData\Local\NVIDIA\GLCache\ -Include *.* -Recurse -ErrorAction SilentlyContinue

		Write-Output "Reset network"
		ipconfig /flushdns
		ipconfig /release
		ipconfig /renew
		netsh winsock reset
		explorer.exe