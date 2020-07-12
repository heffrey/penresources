PowerShell.exe -com {$file=(gi c:\demo\test.txt);$date='01/03/2006 12:12 pm';$file.LastWriteTime=$date;$file.LastAccessTime=$date;$file.CreationTime=$date}
