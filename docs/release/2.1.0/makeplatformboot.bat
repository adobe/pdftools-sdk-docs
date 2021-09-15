@echo off

set root=..\..\..\docs\release\1.2.0


::::::::::::: Make HTML

:: Build html docs
sphinx-build -P -b html -d ..\..\doctrees\ -a . %root%

rmdir /s /q %root%\_sources\
rmdir /s /q ..\..\doctrees\
rmdir /s /q %root%\_static\bootstrap-2.3.2
rmdir /s /q %root%\_static\bootswatch-2.3.2
del %root%\.buildinfo
del %root%\objects.inv