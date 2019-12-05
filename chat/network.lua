local Packet      = require("chat.packet")
local Socket      = require("omg.net.tcp")
local Remote      = require("chat.remote")

local function onerror(socket, errcode, errstr)
  print("ERROR:", socket:getsockname(), errcode, errstr)
end

local function onconnected(socket, listen)
  socket.remote = Remote(socket)
end

local function ondisconnected(socket)
  socket.remote:disconnected()
  socket.remote = nil;
end

local function onrecv(socket, data) -- detta körs när ett paket, innan paketet är parseat.
  local packet_id = data:get_id() -- hämta id på paketet, motsvarar packet.lua CS_LOGIN till exempel
  local func = Packet[packet_id] -- ta ut funktionen ifrån packet.lua till exempel Packet[Packet.CS_LOGIN] 
  if func == nil then
    print("ERROR: packet_id not found", packet_id)
    socket:close()
  end

  if func(socket.remote, data) then -- här kör vi funktionen 
    print("ERROR: packet_id invalid data", packet_id)
    socket:close()
  end
end

local function network(config)
  local listener = Socket.packet_server({
    host            = config.host,
    port            = config.port,
    onerror         = onerror,
    onconnected     = onconnected,
    ondisconnected  = ondisconnected,
    onrecv          = onrecv,
    oneof           = oneof,
  })

  return listener
end

return network
