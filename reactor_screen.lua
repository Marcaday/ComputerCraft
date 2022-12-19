native= term.current()
reactor = peripheral.wrap("fissionReactorLogicAdapter_2")
monitor = peripheral.find("monitor")
monitor.setTextScale(2)
term.redirect(monitor)
mWidth, mHeight = term.getSize()
term.setBackgroundColor(colors.gray)
term.clear()

local rStatus
local rTemperature 

function drawStatusWindow(wStatusWindow, rStatus, rTemperature)
	x, y= 1, 1
	wStatusWindow.setCursorPos(x,y)
	wStatusWindow.setBackgroundColor(colors.gray)
	wStatusWindow.clear()
	wStatusWindow.write("Reactor is "..tostring(rStatus))
	wStatusWindow.setCursorPos(x, y+2)
	wStatusWindow.write("Temperature: "..string.format("%.2f", rTemperature).."°C")
end

function drawButtonWindow(wButtonWindow, rStatus)
	if rStatus then
		wButtonWindow.setBackgroundColor(colors.lime)
		wButtonWindow.clear()
		wButtonWindow.setCursorPos(1, 7)
		wButtonWindow.write("ON")
	else
		wButtonWindow.setBackgroundColor(colors.red)
		wButtonWindow.clear()
		wButtonWindow.setCursorPos(1, 7)
		wButtonWindow.write("OFF")
	end
end

function check_button(x,y,)
	if y >= 6 and y <= 8 and x>=1 and x<=4 then
		if rStatus then
			reactor.scram()
		else
			reactor.activate()
		end
	end

end
wStatusWindow = window.create(term.current(), 1, 1,  mWidth, 6)
wButtonWindow = window.create(term.current(), 1, 7,  8, 4)
while true do
	rStatus = reactor.getStatus()
	rTemperature = reactor.getTemperature()-273.15
	drawStatusWindow(wStatusWindow, rStatus, rTemperature)
	drawButtonWindow(wButtonWindow, rStatus)
	
	local event, button, cx, cy = os.pullEvent()
	rStatus = reactor.getStatus()
	if event == "monitor_touch" then 
		check_button(cx, cy, mWidth, mHeight, rStatus)
	end
end
