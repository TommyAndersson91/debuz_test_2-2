local Class      = require("omg.class")
local Game       = require("chat.game")

local Remote     = Class("chat.remote")

------------------------------------------------------------------------------
-- public
------------------------------------------------------------------------------

function Remote:__init(socket)
  self.socket = socket
  self.user = nil
  self.uid = nil
end

function Remote:disconnected() -- clienten stänger uppkopplingen
  if self.uid then
    Game.unregister_user(self)
  end
  self.socket = nil
end

function Remote:send(packet) -- denna använder vi för att skicka ett paket till en klient, vilket klient den skall till, är i paketet i sig
  self.socket:send(packet)
end

function Remote:close() -- stäng uppkopplingen ifrån serversidan
  self.socket:shutdown()
end

function Remote:recv_login(user) -- detta körs när clienten skickar ett login paket
  Game.chat(user, "joined") -- på socketen (uppkopplingen) mot user. Kör Game.Chat

  self.user = user
  Game.register_user(self)
end

function Remote:recv_chat(message) -- detta körs när clienten skickar ett chat paket
  Game.chat(self.user, message)
end

return Remote
