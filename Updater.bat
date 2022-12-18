rd /s /q .\Update 
rd /s /q .\Resources 
git clone https://github.com/liwhy1/WTC-Windows-Tool-Collective .\Update
robocopy .\Update .\ /xa:H /IM /E
taskkill /F /IM collectivetoolstest.exe /T
collectivetoolstest.exe