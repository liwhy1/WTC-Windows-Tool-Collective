rd /s /q .\Update 
rd /s /q .\Resources 
git clone https://github.com/liwhy1/WTC-Windows-Tool-Collective .\Update
ren .\Update\collectivetoolstest.exe collectivetoolstest_exe.new
ren .\Update\collectivetoolstest.dll collectivetoolstest_dll.new
ren .\Update\collectivetoolstest.pdb collectivetoolstest_pdb.new
robocopy .\Update .\ /xa:H /IM /E
ren .\Update\collectivetoolstest.exe.new collectivetoolstest_exe
ren .\Update\collectivetoolstest.dll.new collectivetoolstest_dll
ren .\Update\collectivetoolstest.pdb.new collectivetoolstest_pdb