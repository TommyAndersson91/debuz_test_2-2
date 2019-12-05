#!/bin/sh

echo "OMG Server " $(date +"[%d-%m-%Y %H:%M:%S]")  

if [ "$(uname)" == "Darwin" ]; then
  export LUA_PATH="?;?.lua;engine/osx/?.lua"
else
  export LUA_PATH="?;?.lua;engine/linux/?.lua"
fi

if [ "$(uname)" == "Darwin" ]; then
  ./engine/osx/omg start.lua
else
  ./engine/linux/omg start.lua
fi
