local lId = os.getComputerID()
rednet.open("back")
local lLogP = "MLP"

while true do 
	senderID, message = rednet.receive(lLogP)
	print(senderID.."-"..message)
end