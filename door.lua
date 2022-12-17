local args = {...}

local arg = args[1]
local senderID = args[2]




function door(arg, senderID)
	local lId = os.getComputerID()
	local lErrorP = "MerrorP"
	local lLogP = "MLP"
	local lFarmControlSide = "up"
	if arg == "open" or arg == "Open" then
		redstone.setOutput(lFarmControlSide, false)
		rednet.broadcast(lId.."- Maintenance doors are now "..arg, lLogP)
	elseif arg == "close" or arg == "Close" then
		redstone.setOutput(lFarmControlSide, true)
		rednet.broadcast(lId.."- Maintenance doors are now "..arg, lLogP)
	else
		rednet.send(senderID, lId.."- Error: Unknown command for Maintenance doors", lErrorP)
		rednet.broadcast(lId.."- Error: Unknown command for Maintenance doors", lLogP)
		rednet.broadcast(lId.."- Error: Unknown command for Maintenance doors", lErrorP)
	end

end

door(arg, senderID)