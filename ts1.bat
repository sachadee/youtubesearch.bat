::YoutubeSearch.bat
::By SachaDee - 2016
::Use and abuse it !!@!

::Usage : Youtubesearch.bat "Bob Marley No woman no cry"
::Tout l'element de recherche doit être entre "..."

::Output
::Tout les liens trouvés (50 au maximum avec ce code !!!)

@echo off
set "$=del"
setlocal enabledelayedexpansion

if not exist #.vbs call:construct
cscript /nologo #.vbs "%~1" >#.txt

for /f "tokens=3 delims==" %%a in ('type #.txt ^| findstr "data-context-item-id" 2^>nul ') do (
   set $link=%%a
   set $link=!$Link:data-visibility-tracking=!
   echo  https://www.youtube.com/watch?v=!$link:~1,-2!
)
%$% #.txt&%$% #.vbs
exit/b

:construct
(echo.Dim o&echo.Set o = CreateObject("MSXML2.XMLHTTP"^)&echo.o.open "GET"^, "https://www.youtube.com/results?search_query=" ^& wscript.arguments(0^),False&echo.o.send&echo.wscript.echo o.responseText)>#.vbs
