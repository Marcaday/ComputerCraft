local lId = os.getComputerID()
rednet.open("back")
local lProtocol = "CCMP"
local lLogP = "MLP"
lConnectId = "Unset"
x,y = 1,1
term.setCursorPos(x,y)
term.blit("RC version : 0.0.1", "000000000000011111" , "ffffffffffffffffff")
term.setCursorPos(x, y+2)
local function split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return (t)
end
 
while true do
    input = read()
    tInput = split(input, " ")
	local connected_ids = {}
    if input == "ls" and lConnectId == "Unset" then
    	connected_ids = {rednet.lookup(lProtocol)}
    	for i=1, #connected_ids do
			rednet.broadcast(lId.." - Asking identity to "..connected_ids[i], lLogP)
        	rednet.send(connected_ids[i], "identity", lProtocol)
        	senderID, message = rednet.receive(lProtocol)
        	term.write(senderID.."-"..message)
			term.setCursorPos(x,y+2)
			y = y+2
    	end
    elseif tInput[1] == "connect"  then
        lConnectId = tonumber(tInput[2])
		lCorrectTokenId = false
		for i=1, #connected_ids do
			if lConnectId == connected_ids[i] then
				lCorrectTokenId = true
				term.write("connect to "..tostring(lConnectId))
			end
		end
		if lCorrectTokenId == false then
			term.write("Unvalid Host : "..tostring(lConnectId))
			lConnectId = "Unset"
		end
		term.setCursorPos(x,y+2)
		y = y+2
    elseif  input == "exit" and lConnectId ~= "Unset" then
        lConnectId = "Unset"
        term.write("Exiting "..tostring(lConnectId))
		term.setCursorPos(x,y+2)
		y = y+2
	elseif input == "logs" and lConnectId == "Unset" then
		while true do 
			local event, key = os.pullEvent("key")
			senderID, message = rednet.receive(lLogP)
			term.write(message)
			term.setCursorPos(x,y+2)
			y = y+2
			if key == "q" then
				break
			end
		end
		term.setCursorPos(x,y+2)
		y = y+2
    else    
		rednet.broadcast(lId.." - Message to "..tostring(lConnectId)..": "..input, lLogP)
		rednet.send(lConnectId, input, lProtocol)
    end
    end