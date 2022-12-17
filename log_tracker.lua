local lId = os.getComputerID()
native = term.current()
monitor = peripheral.find("monitor")
if monitor then
	term.redirect(monitor)
end
rednet.open("bottom")
local identity = "RemoteController"
local lLogP = "MLP"
rednet.host(lLogP, identity)
while true do 
	senderID, message = rednet.receive(lLogP)
	term.write(senderID.."-"..message)
	native.write(senderID.."-"..message)
end