rednet.open("bottom")
identity = "Default Identity"
 
 
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
 
function RemoteReceiver(identity)
    local lId = os.getComputerID()
    local lProtocol = "CCMP"
    local lErrorP = "MerrorP"
    local lLogP = "MLP"
    local lSupportedMessages = {"identity", "reboot", "kelp_farm", "door"}
    local lSenders_control = {"5", "id"}
    rednet.host(lProtocol, identity)
    rednet.host(lErrorP, identity)
    rednet.host(lLogP, identity)
    while true do
		local lcommand_token = 0
		local lsender_token = 0
        senderID, message = rednet.receive(lProtocol)
        lmessage =  split(message, " ")
        command = lmessage[1]
        args = lmessage[2]
        for i=1, #lSenders_control do
            if tostring(senderID) == lSenders_control[i] then
				lsender_token = 1
                for j=1, #lSupportedMessages do
                    if command == lSupportedMessages[j] then
						lcommand_token = 1
                        if command == "identity" then
							rednet.broadcast(lId.." - Sending Identity: "..identity, lLogP)   
                            rednet.send(senderID, identity, lProtocol)
                        else
							rednet.broadcast(senderID.." - Asking to run: "..message.." on "..lId, lLogP)
                            multishell.launch({}, command..".lua", args, senderID)
                        end
                    end
                end
				if lcommand_token == 0 then
					rednet.send(senderID, lId.." - Error: Unknown message from "..tostring(senderID), lErrorP)
					rednet.broadcast(lId.." - Error: Unknown message from "..tostring(senderID), lLogP)
				end
				end
            end
			if lsender_token == 0 then
				rednet.send(senderID, lId.." - Error:"..tostring(senderID).." Does not have permissions to talk", lErrorP)
				rednet.broadcast(lId.." - Error:"..tostring(senderID).." Does not have permissions to talk", lLogP)
			end
        end
end

 
RemoteReceiver(identity)