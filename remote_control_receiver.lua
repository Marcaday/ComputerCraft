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
    local lSupportedMessages = {"identity", "kelp_farm", "door"}
    local lSenders_control = {"5", "id"}
    rednet.host(lProtocol, identity)
    rednet.host(lErrorP, identity)
    rednet.host(lLogP, identity)
    while true do
        senderID, message = rednet.receive(lProtocol)
        lmessage =  split(message, " ")
        command = lmessage[1]
        args = lmessage[2]
        for i=1, #lSenders_control do
            if tostring(senderID) == lSenders_control[i] then
                for j=1, #lSupportedMessages do
                    if command == lSupportedMessages[j] then
                        if command == "identity" then
							rednet.broadcast(lId.."-Sending Identity: "..identity, lLogP)   
                            rednet.send(senderID, identity, lProtocol)
                        else
							rednet.broadcast(senderID.."-Asking to run :"..message.." on -"..lId, lLogP)
                            multishell.launch({}, command..".lua", args, senderID)
                        end
                    else
                        rednet.send(senderID, lId.." - Error: Unknown message", lErrorP)
                    end
                end
            end
        end
end
end
 
RemoteReceiver(identity)