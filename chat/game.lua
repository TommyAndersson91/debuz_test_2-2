local Packet = require("chat.packet")

-- If a user leaves the chat room, The list of users does not remove that player properly,
-- it still remains in the list, and there is no announcement that that user has left the chat room 
-- (fix only .lua files in the server folder).


local Game = {}

--------------------------------------------
--- private
--------------------------------------------

local ccu = 0
local users = {}

local function add_user(remote)
  for uid, r in pairs(users) do
    r:send(Packet.make_add_user(remote.uid, remote.user))
  end
end

local function remove_user(remote)
 
  for uid, r in pairs(users) do
     r:send(Packet.make_remove_user(remote.uid))
  end
end



--------------------------------------------
--- public
--------------------------------------------

function Game.register_user(remote)
  local uid = #users + 1

  remote.uid = uid
  users[uid] = remote

  add_user(remote)

  ccu = ccu + 1
  print("CCU = " .. ccu)
end

function Game.unregister_user(remote)
  local uid = remote.uid
  remove_user(remote)
    local mess = "The user has left the chat  " .. remote.user
  Game.chat(remote.user, mess)
  

  users[uid] = nil

    ccu = ccu - 1

  remote.uid = nil
  remote.user = nil

 


end

function Game.chat(user, message)
  for uid, r in pairs(users) do
    r:send(Packet.make_chat(user, message)) -- skicka make_chat paket för varje användare till varje användare   

  end
  print("Make chat for = " .. user)
end
  
return Game
