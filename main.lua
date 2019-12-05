print("OMG platform Copyright (c) 2010 - 2016 Debuz Co., Ltd. All Right Reserved.\n")

local Config      = require("config")
local Game        = require("chat.game")
local Network     = require("chat.network")
local Scheduler   = require("omg.scheduler")

print("game  database host: "..Config.game_db.host..", database name: "..Config.game_db.database)

Game.listener     = Network(Config.network)
print("game  server listen on: "..Config.network.host..":"..Config.network.port.."\n")

print("started on "..os.date("%Y-%m-%d %H:%M:%S",  os.time()).."\n")


