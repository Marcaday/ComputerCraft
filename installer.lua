local params = {...}
local item = params[1]
if item == "menu" then
	shell.run("rm menu.lua")
	shell.run("wget https://github.com/Marcaday/ComputerCraft/raw/main/menu.lua menu.lua")
elseif item == "remote_control" then
	shell.run("rm menu.lua")
	shell.run("wget https://github.com/Marcaday/ComputerCraft/raw/main/remote_control.lua remote_control.lua")
elseif	item == "remote_control_receiver" then
	shell.run("rm menu.lua")
	shell.run("wget https://github.com/Marcaday/ComputerCraft/raw/main/remote_control_receiver.lua remote_control_receiver.lua")
else if item == "installer" then
	shell.run("rm installer.lua")
	shell.run("wget https://github.com/Marcaday/ComputerCraft/raw/main/installer.lua installer.lua")
end
end