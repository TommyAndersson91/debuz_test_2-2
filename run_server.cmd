@echo off



SET RUN=win\omg.exe 

TITLE OMG Server - %RUN%     [ %DATE% %TIME:~0,8% ]

engine\%RUN% start.lua

pause

