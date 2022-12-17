rednet.open("top")
identity = "Default Identity"


local function split(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={}
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		table.insert(t, str)
	end
end

function RemoteReceiver(identity)
	local lId = os.getComputerID()
	local lProtocol = "CCMP"
	local lErrorP = "MerrorP"
	local lLogP = "MLP"
	local lSupportedMessages = {"identity", "kelp_farm", "door"}
	local lSenders_control = {"id1", "id"}
	rednet.host(lProtocol)
	rednet.host(lErrorP)
	rednet.host(lLogP)
	while true do
	
		rednet.broadcast(lId.." is Up", lProtocol)
		rednet.broadcast(lId.." is Up", lLogP)
		senderID, message = rednet.receive(lProtocol)
		lmessage =  split(message, " ")
		command = lmessage[1]
		args = table.remove(message, 1)
		for sender in lSenders_control do
			if senderID == sender then
				for lMessage in lSupportedMessages do
					if command[1] == lMessage then 
						if command[1] == "identity" then
							rednet.send(senderID, identity, lProtocol)
							rednet.broadcast(lId.."-Sending Identity: "..identity, lLogP)	
						else
							multishell.launch({}, command, args[1], senderID)
							rednet.broadcast(senderID.."-Asking to run :"..message.." on -"..lId, lLogP)
						end
					else
						rednet.send(senderID, lId.." - Error: Unknown message", lErrorP)
					end
				end
			end
		end
end
end