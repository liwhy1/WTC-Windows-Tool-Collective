taskkill /f /im "Windows Tool Collective.exe"
rd /s /q .\Update 
rd /s /q .\Resources
del "Windows Tool Collective.exe"
del "Windows Tool Collective.dll"
del "Windows Tool Collective.deps.json"
del "Windows Tool Collective.runtimeconfig.json"
del "Microsoft.Windows.SDK.NET.dll"
del "WinRT.Runtime.dll"
git clone https://github.com/liwhy1/WTC-Windows-Tool-Collective .\Update
robocopy .\Update .\ /xa:H /IM /E
del "README.md"

"Windows Tool Collective.exe"