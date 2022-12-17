local lId = os.getComputerID()
rednet.open("back")
local lProtocol = "CCMP"
local lLogP = "MLP"
lConnectId = -1
x,y = 1,1
term.setCursorPos(x,y)
 
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
    if input == "ls" and lConnectId == -1 then
    local connected_ids = {rednet.lookup(lProtocol)}
    for i=1, #connected_ids do
                rednet.send(connected_ids[i], "identity", lProtocol)
            rednet.broadcast(lId.."- Asking identity to "..connected_ids[1], lLogP)
            senderID, message = rednet.receive(lProtocol)
            term.write(senderID.."-"..message)
			term.setCursorPos(x,y+2)
        end
    elseif tInput[1] == "connect"  then
        lConnectId = tonumber(tInput[2])
        term.write("connect to "..tostring(lConnectId))
		term.setCursorPos(x,y+2)
    elseif  input == "exit" and lConnectId ~= -1 then
        lConnectId = -1
        term.write("Exiting "..tostring(lConnectId))
		term.setCursorPos(x,y+2)
    else    
        rednet.send(lConnectId, input, lProtocol)
        rednet.broadcast(lId.."-"..input.." to "..tostring(lConnectId), lLogP)
    end
    end