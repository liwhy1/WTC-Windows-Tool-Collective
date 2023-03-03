Write-Output "Changing ExecutionPolicity to allow scripts to run, Press "Y" if prompted!"
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned -Force