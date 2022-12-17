local lId = os.getComputerID()
x,y = 1, 1
native = term.current()
monitor = peripheral.find("monitor")
if monitor then
 monitor.setTextScale(0.5)
    term.redirect(monitor)
term.clear()
 w, h = term.getSize()
 native.write("w"..w.."h"..h)
end
rednet.open("top")
local identity = "RemoteController"
local lLogP = "MLP"
rednet.host(lLogP, identity)
while true do 
    senderID, message = rednet.receive(lLogP)
    term.write(message)
term.setCursorPos(x, y+2)
if y == (h) then
term.clear()
y=1
end
y = y+2
end