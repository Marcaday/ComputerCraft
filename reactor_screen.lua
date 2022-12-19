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
local cButtonStartx, cButtonStarty = 1, 6
local cButtonSizex, cButtonSizey = 4, 9

wStatusWindow = window.create(term.current(), 1, 1,  mWidth, 6)
wButtonWindow = window.create(term.current(), cButtonStartx, cButtonStarty,  cButtonSizex, cButtonSizey)

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
		wButtonWindow.setCursorPos(cButtonSizex/2, cButtonSizey/2)
		wButtonWindow.write("ON")
	else
		wButtonWindow.setBackgroundColor(colors.red)
		wButtonWindow.clear()
		wButtonWindow.setCursorPos(cButtonSizex/2, cButtonSizey/2)
		wButtonWindow.write("OFF")
	end
end

function check_button(x,y)
	if y >= cButtonStarty 
	and y <= cButtonStarty + cButtonSizey
	and x >=  cButtonStartx
	and x <= cButtonStartx + cButtonSizex 
	then
		if rStatus then
			reactor.scram()
		else
			reactor.activate()
		end
	end

end

function update_display()
	while true do
		rStatus = reactor.getStatus()
		rTemperature = reactor.getTemperature()-273.15
		if rTemperature >= 400 and rStatus then
			reactor.scram()
		end
		drawStatusWindow(wStatusWindow, rStatus, rTemperature)
		drawButtonWindow(wButtonWindow, rStatus)
	end
end

function get_events()
	while true do
		local event, button, cx, cy = os.pullEvent("monitor_touch")
		rStatus = reactor.getStatus()
	end
end

parallel.waitForAny(get_events, update_display)