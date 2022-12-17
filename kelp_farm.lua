local args = {...}

local arg = args[1]
local senderID = args[2]




function kelp_farm(arg, senderID)
	local lId = os.getComputerID()
	local lErrorP = "MerrorP"
	local lLogP = "MLP"
	local lFarmControlSide = "right"
	if arg == "on" or arg == "On" then
		redstone.setOutput(lFarmControlSide, false)
		rednet.broadcast(lId.."- Kelp farm is i now "..arg, lLogP)
	elseif arg == "off" or arg == "Off" then
		redstone.setOutput(lFarmControlSide, true)
		rednet.broadcast(lId.."- Kelp farm is i now "..arg, lLogP)
	else
		rednet.send(senderID, lId.."- Error: Unknown command for kelp_farm", lErrorP)
		rednet.broadcast(lId.."- Error: Unknown command for kelp_farm", lLogP)
		print("Error: Unknown command")
	end

end

kelp_farm(arg, senderID)