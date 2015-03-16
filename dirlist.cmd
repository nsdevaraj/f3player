@echo off
echo 		ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ  
echo 		Ý Creating the F3 Playlist - please wait.. Þ
echo 		ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
dir c:\*.mp3/s/b/w/l>fcdir.txt
dir d:\*.mp3/s/b/w/l>fddir.txt
dir e:\*.mp3/s/b/w/l>fedir.txt
dir f:\*.mp3/s/b/w/l>ffdir.txt
dir g:\*.mp3/s/b/w/l>fgdir.txt
dir h:\*.mp3/s/b/w/l>fhdir.txt
type fcdir.txt , fddir.txt , fedir.txt , ffdir.txt , fgdir.txt , fhdir.txt  >dir.txt
del f?dir.txt /q
f3.exe
exit