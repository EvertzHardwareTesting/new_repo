
cd %localhost%

del ftp.txt

echo open %2 %3 > ftp.txt
echo /r >> ftp.txt
echo /r >> ftp.txt
echo del cap_000.bmp >> ftp.txt
echo quote site capture_%1 single >> ftp.txt
echo bye >> ftp.txt

ftp -s:ftp.txt






