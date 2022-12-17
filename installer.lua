local params = {...}
if params[1] == "menu" then
	shell.run("rm menu.lua")
	shell.run("wget https://github.com/Marcaday/ComputerCraft/raw/main/menu.lua menu.lua")
elseif params[1] == "remote_control" then
	shell.run("rm remote_control.lua")
	shell.run("wget https://github.com/Marcaday/ComputerCraft/raw/main/remote_control.lua remote_control.lua")
elseif	params[1] == "remote_control_receiver" then
	shell.run("rm remote_control_receiver.lua")
	shell.run("wget https://github.com/Marcaday/ComputerCraft/raw/main/remote_control_receiver.lua remote_control_receiver.lua")
else if params[1] == "installer" then
	shell.run("rm installer.lua")
	shell.run("wget https://github.com/Marcaday/ComputerCraft/raw/main/installer.lua installer.lua")
else if params[1] == "kelp_farm" then
	shell.run("rm kelp_farm.lua")
	shell.run("wget https://github.com/Marcaday/ComputerCraft/raw/main/kelp_farm.lua kelp_farm.lua")
else if params[1] == "kelp_farm" then
	shell.run("rm kelp_farm.lua")
	shell.run("wget https://github.com/Marcaday/ComputerCraft/raw/main/kelp_farm.lua door_controllua")
end
end
end