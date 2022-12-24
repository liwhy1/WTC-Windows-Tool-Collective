taskkill /f /im "Windows Tool Collective.exe"
rd /s /q .\Update 
rd /s /q .\Resources
del collectivetoolstest.exe
del collectivetoolstest.dll
del collectivetoolstest.pdb
git clone https://github.com/liwhy1/WTC-Windows-Tool-Collective .\Update
robocopy .\Update .\ /xa:H /IM /E
"Windows Tool Collective.exe"
