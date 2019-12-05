local Engine    = require("omg.v1")
local Native    = require("luaomg")
local Scheduler = require("omg.scheduler")

local Main      = assert(loadfile("main.lua"))

Scheduler.add(Main)
Scheduler.run()

print("terminated")
