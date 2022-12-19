native= term.current()
reactor = peripheral.wrap("fissionReactorLogicAdapter_2")
monitor = peripheral.wrap("back")

monitor.setTextScale(2.5)
term.redirect(monitor)
term.setBackgroundColor(colors.gray)
term.clear()
choice1 = "On"
choice2 = "Off"
while true do
	x,y = 1,1
	term.setCursorPos(x,y)
	term.clearLine()
	local rStatus = reactor.getStatus()
	local rTemperature = reactor.getTemperature()-273.15
	term.write("Reactor is "..tostring(rStatus))
	term.setCursorPos(x, y+3)
	term.write("Temperature : "..string.format("%.2f", rTemperature).."°C")
	term.setCursorPos(1, 7)
	write(choice1)
 
	term.setCursorPos(1, 10)
	write(choice2)
	local event, button, cx, cy = os.pullEvent()
 
	if event == "monitor_touch" then 
    	if cy == 7 and rStatus == false then
        	reactor.activate()
    	elseif cy == 10 and rStatus == true then
        	reactor.scram()
    	end
	end
end