-- This is eniallator's Control program's plugin template.
-- Link to Control program: http://pastebin.com/ss0BX2mM
-- This file goes into the folder that you have specified in the pluginFolder variable in the Control program.
--
-- ================================================================================
--
-- The key you have given your function that you have given in the function table is how you are going to call your function in the remote computer's command line. For example inputting "testFunc arg1 arg2" would call the function testfunc from the functionTable and in the function argument it would then pass the following arguments: ({"arg1","arg2"},*ID of remote computer thats connected*,*protocol thats being used*).
--
-- DISCLAIMER: this acts as the same as the way you would create your function in the control program before, just the status, helpTable and functionTable tables can be accessed from here. I have also made it so that plugin's functions have priority over the control program's functions e.g you can rewrite the default functions from a plugin.
 
status = {kelp_farm = 1}
	-- Just add more keys/values the same way as the first one is laid out
	 
	helpTable = {kelp_farm = "Enable/Disable the Kelp farm"}
	-- Just add more keys/values the same way as the first one is laid out
	 
	functionTable = {
		kelp_farm= function(userInput, connectedComputerID, protocol) 
			if userInput[1] == "on" then
				redstone.setOutput("bottom", false)
				rednet.send(connectedComputerID, "Kelp farm is now " .. userInput[1], protocol)
			elseif userInput[1] == "off" then
				redstone.setOutput("bottom", true)
				rednet.send(connectedComputerID, "Kelp farm is now " .. userInput[1], protocol)
			end
		 end
		
	}
	-- Just add more keys/values the same way as the first one is laid out