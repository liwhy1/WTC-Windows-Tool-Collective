rd /s /q .\Update 
rd /s /q .\Resources 
git clone https://github.com/liwhy1/WTC-Windows-Tool-Collective .\Update
ren .\Update\collectivetoolstest.exe collectivetoolstest_exe.old
ren .\Update\collectivetoolstest.dll collectivetoolstest_dll.old
ren .\Update\collectivetoolstest.pdb collectivetoolstest_pdb.old
robocopy .\Update .\ /xa:H /IM /E
del collectivetoolstest_exe.old
del collectivetoolstest_dll.old
del collectivetoolstest_pdb.old