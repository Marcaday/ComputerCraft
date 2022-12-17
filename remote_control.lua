local lId = os.getComputerID()
rednet.open("back")
local lProtocol = "CCMP"
local lLogP = "MLP"
local connected_ids = {rednet.lookup(lProtocol)}

for i=1, #connected_ids do
	print(connected_ids[i])
end

while true do
	rednet.send(connected_ids[i], "identity", lProtocol)
	rednet.broadcast(lId.."- Asking identity to "..connected_ids[1], lLogP)
	senderID, message = rednet.receive(lProtocol)
	print(message)
	senderID, message = rednet.receive(lLogP)
	print(message)
end